Un random file usa una funzione di hashing per ottenere accesso diretto ai record, riducendo drasticamente il numero di accessi a blocco, a costo di non supportare ricerche ordinate o per intervalli.

---
###  STRUTTURA

Nel **random file (hash file)** esiste una **relazione diretta** tra il valore della **chiave di ricerca** e la **posizione fisica** del record sul disco. Il file è suddiviso in **bucket** e ogni bucket occupa uno o più **blocchi**. Ogni blocco contiene:

- un **header** (metadati, bitmap degli slot)
- una collezione di **record**

Un **algoritmo di hashing** trasforma il valore della chiave in un **indirizzo di bucket**. I record con chiavi che producono lo stesso valore hash sono memorizzati nello **stesso bucket**.

---
### PARAMETRI

Numero **massimo** di record che **un bucket può contenere**:

$$CAP = \left\lfloor\frac{BS}{RS}\right\rfloor$$

Dove:

- **BS** = dimensione del bucket (in byte)
- **RS** = dimensione dei record (in byte)

---

Numero di record che finiscono **in media** in un bucket:

$$AVG = \frac{NR}{NB}$$

Dove:

- **NR** = numero totale di record nel file
- **NB** = numero di bucket

---

Il **numero di bucket dell’area primaria (non in overflow) del file hash**, cioè il numero di indirizzi distinti generabili dalla funzione di hashing:

$$NB = \left\lceil \frac{NR}{BS \times LF} \right\rceil$$

Dove:

- **LF** = loading factor

---

Il **loading factor** indica **quanto è pieno un bucket in media**:

$$LF = \frac{AVG}{CAP}$$

Tipicamente tra **0.7 e 0.9**.

---
### FUNZIONAMENTO

#### Hashing e indirizzamento

Un **hash function** definisce la trasformazione:

<b>address(key<sub>i​</sub>) = key<sub>i</sub> mod M</b>

- **M** = numero di indirizzi hash possibili (spesso un numero primo vicino ma leggermente più grande di **NB**)
- il resto (mod) della divisione determina il bucket di destinazione

L’obiettivo è ottenere una **distribuzione uniforme** delle chiavi sui bucket.

> N.B. La mappatura attraverso la funzione hash porta inevitabilmente a generare [[Collision|collisioni]] e [[Overflow|overflow]]: problemi logici dei file hash.

---
#### Inserimento

Inserire un nuovo record richiede:

- calcolare l’hash della chiave
- accedere direttamente al bucket corrispondente
- se il bucket corrispondente ha spazio: inserimento immediato
- se il bucket è pieno: gestione dell’[[Overflow|overflow]] (dipende dalla tecnica adottata)

**Costo medio**:

- 1 **RBA** per il bucket primario
- eventuali **SBA o RBA** per i blocchi di overflow

---
#### Ricerca

La struttura indicizzata permette accessi diretti ai blocchi:

---

**Hashing e indexing:**

- si calcola l’hash della chiave
- si accede **direttamente** al bucket
- se il record non è nel blocco principale: si esplorano i blocchi di overflow

**Costo medio**:

- **1 RBA** per record senza overflow
- **1 RBA** + eventuali **SBA** per record in overflow:

---
### ESEMPIO
![[primary file organization.png]]
**Hash file:**

- **Capacità bucket (CAP)** = **2** record per blocco
- **NR** = **5** record → **NB** = **⌈5/2⌉** = **3** bucket necessari
- Scegliamo **M = 5** (numero primo > **NB**)

```powershell
FILE HASH
|
├─ BUCKET 0 [Blocco 1, Header: num_records=1]
|  └─ Record: 325, Serena, Pianto
|
├─ BUCKET 1 [Blocco 2, Header: num_records=2]
|  ├─ Record: 101, Giulio, Informatica
|  └─ Record: 416, Simone, Psicologia
|
├─ BUCKET 3 [Blocco 3, Header: num_records=1]
|  └─ Record: 208, Riccardo, Lamentologia
|
└─ BUCKET 4 [Blocco 4, Header: num_records=1]
   └─ Record: 104, Andrea, Informatica
```

---