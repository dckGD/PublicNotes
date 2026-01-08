Una **matrice M × N** è vista come una successione di **M [[Arrays|vettori]]** (righe), ciascuno contenente **N elementi** (colonne).

---

**Elementi totali:** M × N
**Dimensione totale in byte:** M × N × (dimensione in byte di un elemento)
**Memorizzazione:** Le matrici sono memorizzate in memoria come un **vettore "appiattito"** contenente M×N elementi, ordinati (di solito) in **row-major order** (riga per riga).

---
### DEFINIZIONE STATICA IN ASSEMBLY

Per esempio, consideriamo una matrice di dimensioni 7 × 13, in cui ogni elemento è una word (4 byte).

**Calcolo dei parametri:**

**Numero totale di elementi:**  M × N = 7 × 13 = 91 elementi
**Dimensione totale in byte:**  91 × 4 byte = 364 byte

---
#### Definizione con una direttiva assembly

In molti assembler è possibile utilizzare una sintassi compatta per definire un vettore con tutti gli elementi uguali. Ad esempio:

```assembly
.data 
Matrice: .word 0:91   # Alloca 91 word, inizializzate tutte a 0
```

La matrice viene trattata come un vettore di 91 elementi, che nella logica di una matrice 7 × 13 è composto da 7 righe ciascuna di 13 elementi.

---
### ORGANIZZAZIONE IN MEMORIA 

Come abbiamo già detto, in memoria una matrice è salvata come un unico array e le modalità di organizzazione principali sono due (solitamente si utilizza il primo):

---
#### C-style (Row-major order)

**Definizione:**  

Le righe della matrice sono memorizzate in maniera contigua in memoria.

**Implicazione:**  

Dopo la fine di una riga, gli elementi della riga successiva occupano gli indirizzi immediatamente successivi.

**Calcolo dell'indirizzo:**  

Per accedere a un elemento `A[x][y]` in una matrice M×N, l'indirizzo si calcola così:

$$
indirizzo = base + ((x\ ×\ N)\ +\ y)\ ×\ sizeof(elemento)
$$

**Esempio:**

Accesso a `A[2][5]`:
**Calcolo dell'offset logico:** riga = 2, colonna = 5
**Offset in elementi** = 2 × 13 + 5 = 26 + 5 = 31
**Conversione in byte:** Offset in byte = 31 × 4 = 124 byte
**Calcolo indirizzo:** Se la base è 0x10010000, allora l'indirizzo di `A[2][5]` = 0x10010000 + 124 = 0x1001007C

---
#### Fortran-style (Column-major order)

**Definizione:**  

Le colonne della matrice sono memorizzate in maniera contigua.

**Implicazione:**  

Dopo la fine di una colonna, gli elementi della colonna successiva occupano gli indirizzi immediatamente successivi.

**Calcolo dell'indirizzo:**  

Per accedere a un elemento `A(x,y)` in una matrice M×N, l'indirizzo si calcola così:

$$
indirizzo = base + ((y\ ×\ M)\ +\ x)\ ×\ sizeof(elemento)
$$

---
### MATRICI 3D

Possiamo immaginare una matrice 3D come una serie di L matrici 2D sovrapposte. Anche una matrice 3D è memorizzata in modo contiguo (appiattita) (in row-major order) in memoria. 

---
#### Dimensioni della matrice 3D

La matrice ha dimensioni **L × M × N**, dove:

- **L** è il numero di "strati" (o matrici 2D),
- **M** è il numero di righe in ciascuno strato,
- **N** è il numero di colonne in ciascuna riga.

**Struttura:**  

La matrice 3D si concepisce come una successione di **L matrici 2D** (ognuna di dimensioni M×N) memorizzate in sequenza.

---
#### Calcolo dell'Indice dell'Elemento

L’elemento alle coordinate (z, x, y) è preceduto da:

1. **z interi strati**: Ogni strato contiene M×N elementi.  
2. **x righe** all'interno dello strato corrente: Ogni riga contiene N elementi.  
3. **y elementi** all'interno della riga corrente.

---
Pertanto, l’offset in numero di elementi (a partire dall'inizio della matrice lineare) è:

$$
offset\_elementi\ =\ z\ ×\ (M\ ×\ N)\ +\ x\ ×\ N\ +\ y
$$

Per ottenere la **posizione in memoria** dell’elemento, bisogna moltiplicare tale offset per la dimensione (in byte) di ogni elemento (4 byte nelle architetture a 32 bit), e poi aggiungere l'indirizzo base della matrice:

$$
indirizzo\_elemento\ =\ indirizzo\_matrice\ +\ (z\ ×\ (M\ ×\ N)\ +\ x\ ×\ N\ +\ y)\ ×\ dim\_elemento
$$

---

