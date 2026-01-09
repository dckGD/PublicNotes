Un **tree‑structured index** è una struttura dati gerarchica che organizza le chiavi in nodi collegati ad albero per permettere ricerche, inserimenti e cancellazioni efficienti, sia in memoria che su disco. A differenza degli indici statici (es. [[Indexed Sequential File|ISAM]]), gli alberi mantengono la struttura bilanciata o adattativa durante gli aggiornamenti, evitando overflow estesi verso file di overflow.

---
### PARAMETRI GENERALI

Usa questo schema come riferimento comune in tutte le sezioni.

- **N** = numero totale di nodi.
- **m** (fan-out teorico) = ordine / numero massimo di figli per nodo (prestabilito).
- <b>fan‑out<sub>eff</sub></b> (fan‑out effettivo) = **f x m** (dove **f** è **fill factor medio**, es. 0.5–0.7).
- <b>k<sub>max</sub></b> = numero massimo di chiavi in un nodo.
- <b>k<sub>min</sub></b> = numero minimo di chiavi in un nodo.
- **h** = altezza dell'albero (numero di livelli dalla radice alle foglie).

> N.B. Il fan-out (numero di figli per nodo) effettivo è il **fan-out medio realmente osservato**, tenendo conto che in un albero i nodi **non sono sempre pieni** e operazioni come insert e delete creano nodi parzialmente occupati. Per questo al fan-out massimo **m** moltiplichiamo il **fill-factor** (con valori 0 < f ≤ 1).

---
### TIPOLOGIE

Esistono varie tipologie di search tree che differiscono per la struttura logica di base e per la conseguente implementazione fisica:

---
#### BST (Binary Search Tree)

**Descrizione:**

- **Albero binario:** ogni nodo ha al più 2 figli.
- **Proprietà d'ordine:** per ogni nodo vale: chiavi dei nodi del sottoalbero sinistro < chiave del nodo < chiavi dei nodi del sottoalbero destro (valore crescente dei nodi da sinistra a destra).
- Ogni nodo contiene **una chiave**.

---

**Parametri:**

- <b>N<sub>max</sub></b> ≈ <b>2<sup>h</sup> - 1</b> 
- **m** = 2 (numero figli massimo)
- <b>fan‑out<sub>eff</sub></b> ≈ 2
- <b>k<sub>max</sub></b> = 1 (chiave per nodo)
- <b>k<sub>min</sub></b> = 1 (se il nodo esiste)
- **h** = caso medio ≈ <b>log<sub>2</sub>(N + 1)</b>, caso peggiore = **N** (un nodo per livello)

---

**Costo di ricerca:**

Su ogni livello: ricerca sull'unica chiave interna al nodo → <b>O(1)</b>

- Caso medio (albero bilanciato): <b>O(log<sub>2</sub>N)</b>
- Caso peggiore (degenerazione): **O(N)**

---

**Esempio:**

```css
        [50*]
      ┌───┴───┐
    [30*]    [70*]
  ┌───┴───┐    ┴───┐
[20*]    [40*]    [80*]
```

(`*` indica che il nodo contiene il record o il puntatore).

---
#### MST (Multi-way Search Tree)

**Descrizione:**

- **Albero multi-way:** ogni nodo ha fino a **m figli**.
- **Proprietà d'ordine:** per ogni nodo, le chiavi dividono i figli in intervalli ordinati: chiavi < della prima chiave del nodo → nel primo sottoalbero, chiavi > della prima e < della seconda chiave del nodo → nel secondo sottoalbero (tra prima e seconda chiave)… e così via.
- Ogni nodo può contenere fino a **m−1 chiavi**.

---

**Parametri:**

- <b>N<sub>max</sub></b> ≈ <b>(m<sup>h</sup>- 1) / (m - 1)</b>
- **m** ≥ 2 (prestabilito)
- <b>fan‑out<sub>eff</sub></b> ≈ f × m (f = fill factor)
- <b>k<sub>max</sub></b> = **m − 1** (chiavi per nodo)
- <b>k<sub>min</sub></b> = 1 (se non self-balanced)
- **h** ≈ <b>log<sub>fan-out<sub>eff</sub></sub>(N)</b> (altezza stimata)

---

**Costo di ricerca:**

Su ogni livello: ricerca binaria sulle chiavi interne del nodo → <b>O(log<sub>2</sub>k<sub>max</sub>)</b>

- Caso medio (albero bilanciato): <b>O(h x log<sub>2</sub>k<sub>max</sub>)</b> 
- Caso peggiore (degenerazione): <b>O(N x log<sub>2</sub>k<sub>max</sub>)</b>

---

**Esempio:**

MST con **m** = 3:

```css
                    [40*|80*]
         ┌──────────────┼──────────────┐
     [10*|20*]    [50*|55*|60*]      [90*]
  ┌──────┴──────┐
[5*]      [25*|30*|35*]
```

(`*` indica che il nodo contiene il record o il puntatore).

---
#### Disk‑oriented search tree

Gli **alberi disk-oriented** sono strutture logiche progettate per **minimizzare gli accessi al disco** (I/O), ottimizzando lettura e scrittura di pagine. Concettualmente, in questa tipologia di alberi, **ogni nodo corrisponde tipicamente a una pagina disco** contenente più chiavi e puntatori. Ne esistono più tipologie:

---
##### B-tree (Balanced Tree)

**Descrizione:**

- **Albero multi-way:** ogni nodo ha fino a **m** figli.
- **Proprietà d'ordine:** per ogni nodo, le chiavi dividono i figli in intervalli ordinati: chiavi < della prima chiave del nodo → nel primo sottoalbero, chiavi > della prima e < della seconda chiave del nodo → nel secondo sottoalbero (tra prima e seconda chiave)… e così via.
- Ogni nodo (page) può contenere fino a **m−1 chiavi**.
- Riempimento Bottom-Up (prima si cerca di riempire le foglie e poi si sale, rispettando i vincoli).
- **Self-balanced:** leggi sotto.

---

**Albero bilanciato:**

Un albero bilanciato ha le seguenti caratteristiche:

- Tutti i percorsi dalla radice alle foglie hanno sempre la stessa lunghezza.
- Tutti i nodi foglia si trovano allo stesso livello.
- Ogni nodo interno deve avere **sempre** **K + 1 figli**, con **K** = chiavi effettive nel nodo.

Il bilanciamento deve essere rispettato anche dopo nuovi inserimenti o rimozioni, a costo di spostare le chiavi tra i vari nodi. Questa proprietà garantisce di avere sempre l'altezza minima e le prestazioni prevedibili.

---

**Parametri:**

- <b>N<sub>max</sub></b> ≈ <b>(m<sup>h</sup>- 1) / (m - 1)</b>
- **m** ≥ 2 (prestabilito)
- <b>fan‑out<sub>eff</sub></b> ≈ f × m (f = fill factor)
- <b>k<sub>max</sub></b> = **m − 1** (chiavi per nodo)
- <b>k<sub>min</sub></b> = **⌈m/2⌉ − 1** 
- **h** ≈ <b>log<sub>fan-out<sub>eff</sub></sub>(N)</b> (altezza stimata)

---

**Costo di ricerca:**

Su ogni livello: ricerca binaria sulle chiavi interne del nodo → <b>O(log<sub>2</sub>k<sub>max</sub>)</b>

- Costo medio: (Numero di I/O) ≈ **h RBA**
- Caso medio e peggiore sono simili grazie al bilanciamento.

---

**Esempio:**

B-tree con **m** = 4:

```css
				                          [40*|---|---]       
				      ┌───────────────────┘   └───────────────────┐    
				[15*|30*|---]                               [70*|---|---]
	  ┌─────────┘   |   └──────────┐                 ┌──────┘   └──────┐
[10*|11*|13*]  [20*|---|---]  [35*|---|---]    [50*|60*|---]     [80*|---|---]
```

(`*` indica che il nodo contiene il record o il puntatore).

---
##### B<sup>+</sup>‑tree (Balanced Plus Tree)

**Descrizione:**

I <b>B<sup>+</sup>‑tree</b> sono una variante specializzata dei **B‑tree**, progettata per migliorare l’efficienza delle operazioni di ricerca e delle range query nei sistemi orientati al disco. Le due strutture condividono molte proprietà (multi‑way, bilanciate, altezza logaritmica, nodi con capacità variabile), ma differiscono in alcuni aspetti fondamentali. Nei <b>B<sup>+</sup>‑tree</b>:

- I puntatori ai dati si trovano **solo nelle foglie**. I nodi interni contengono **solo chiavi di instradamento**, senza record associati.
- Tutte le foglie sono collegate tramite una **linked list ordinata**, che permette di scorrere le chiavi in ordine crescente in modo sequenziale.
- La ricerca **arriva sempre a una foglia** (mai ad un nodo interno), perché solo le foglie contengono i dati.

---

**Esempio:**

B<sup>+</sup>-tree con **m** = 4:

```css
				                          [ 40|---|---]       
				      ┌───────────────────┘   └───────────────────┐    
				[ 15| 30|---]                               [ 70|---|---]
	  ┌─────────┘   |   └──────────┐                 ┌──────┘   └──────┐
[10*|11*|13*]→ [20*|---|---]→ [35*|---|---]→   [50*|60*|---]→    [80*|---|---]
```

(`*` indica che il nodo contiene il record o il puntatore).

---