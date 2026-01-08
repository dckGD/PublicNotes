Un **heap file** è un file fisico in cui i record sono memorizzati **senza alcun ordinamento** rispetto ai valori degli attributi. Non esiste alcuna relazione tra **chiave di ricerca** e **posizione fisica** del record.

---
### STRUTTURA

Il file è composto da **blocchi (pagine)** di dimensione fissa. Ogni blocco contiene:

- un **header** (metadati, bitmap degli slot)
- una collezione di **record**

I blocchi non hanno ordine logico e i record vengono collocati in base alla **disponibilità di spazio**.

---
### FUNZIONAMENTO

#### Inserimento

Il DBMS individua:

- un blocco con slot liberi, oppure
- alloca un nuovo blocco in coda al file

Il record viene inserito nel primo slot disponibile e non avviene alcuna riorganizzazione del file.

**Costo medio:**

In un file con **NBLK** blocchi:

- tipicamente **1 accesso**
- quasi sempre **SBA**

> N.B. La maggior parte dei DBMS **mantiene una lista o bitmap dei blocchi con spazio libero** (free list o space map). In questo modo il DBMS **sa subito** dove inserire il record: non serve scansionare tutto il file in quanto si accede direttamente al blocco disponibile. Se tutti i blocchi esistenti sono pieni, si alloca un blocco nuovo in coda.  Dunque il costo medio è di **1 accesso**, che può essere **SBA** se contiguo o **RBA** se distante. 

---
#### Ricerca

Poiché non esiste alcuna relazione tra chiave e posizione fisica, l’unico metodo è la ricerca sequenziale:

---

**Linear search:**

- i blocchi vengono letti uno dopo l’altro
- in ogni blocco si confrontano i record con la chiave di ricerca

**Costo medio:**

In un file con **NBLK** blocchi:

- chiave unica: **NBLK/2 accessi** (stop condizionato)
- chiave non unica: **NBLK accessi** (full scan del file)

Gli accessi sono prevalentemente **SBA** e il costo cresce linearmente con la dimensione del file.

> N.B. Stop condizionato: una volta trovato il record con al chiave desiderata, allora, sapendo che **esiste al più un solo record** con quella chiave nel file, la ricerca può terminare.

---
### ESEMPIO
![[primary file organization.png]]
**Heap file:**

- **Capacità bucket (CAP)** = **2** record per blocco

```powershell
FILE HEAP
|
├─ Blocco 1 [Header: num_records=2]
|  ├─ Record: 101, Giulio, Informatica
|  └─ Record: 208, Riccardo, Lamentologia
|
├─ Blocco 2 [Header: num_records=2]
|  ├─ Record: 104, Andrea, Informatica
|  └─ Record: 416, Simone, Psicologia
|
└─ Blocco 3 [Header: num_records=1]
   └─ Record: 325, Serena, Pianto
```

---