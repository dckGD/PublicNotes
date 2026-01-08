Un **sequential file** è un file fisico in cui i record sono memorizzati **in ordine crescente o decrescente** rispetto la chiave di ricerca.

---
### STRUTTURA

Il file è composto da **blocchi (pagine)** di dimensione fissa. Ogni blocco contiene:

- un **header** (metadati, bitmap degli slot)
- una collezione di **record**

Ogni blocco mantiene i record ordinati localmente. L’ordine globale può essere crescente o decrescente e permette ricerche più efficienti. È possibile combinare il file sequenziale con **indici** per migliorare ulteriormente le prestazioni.

---
### FUNZIONAMENTO

#### Inserimento

Inserire un nuovo record richiede:

- **trovare la posizione corretta** per mantenere l’ordine
- eventualmente **spostare record** per fare spazio

Inserimenti casuali sono **costosi**, spesso fatti in **batch**

> N.B. Il lavoro in **Batch** consiste in un accumulo di operazioni da svolgere in blocco. Nel contesto del sequential file gli inserimenti **casuali** sono costosi perché i record devono mantenere l’ordine, quindi, si **accumulano più inserimenti** e li si applica tutti insieme in sequenza. In questo modo si riduce la necessità di spostare continuamente i record e i blocchi. In pratica, il DBMS prende un insieme di nuovi record e li inserisce tutti insieme nella posizione corretta, aggiornando blocchi e ordinamento.

---
#### Ricerca

Come per l'heap file la ricerca può essere sequenziale (con l'aggiunta di stop condizionato), tuttavia, la struttura ordinata del sequential file, permette anche la ricerca binaria:

---
##### Linear search:

Scansione sequenziale dei blocchi con possibilità di **stop condizionato**.

**Costo medio:**

In un file con **NBLK** blocchi:

- **NBLK/2 accessi** (in media)
- tutti **SBA**

> N.B. Stop condizionato: se si incontra un record con chiave maggiore (o minore) di quella cercata, la ricerca può terminare in quanto i record sono ordinati (evita full scan del file nella maggior parte dei casi).

---
##### Binary search:

Approccio possibile perché il file è ordinato (guarda il funzionamento dell'algoritmo di ricerca binaria).

**Costo medio:**

In un file con **NBLK** blocchi:

- <b>log<sub>2​</sub>(NBLK)</b>
- tutti **RBA**

---
##### Esempio:

**NR** = 30.000 record, **RS** = 100 bytes, **BS** = 2048 bytes
**BF** = **⌊BS/RS⌋** = 20 record per blocco
**NBLK** = 30.000 / 20 = 1.500 blocchi

**Linear search** → 1.500 / 2 = 750 **SBA**
**Binary search** → log₂(1.500) ≈ 11 **RBA**

> N.B. Anche se gli **RBA** richiedono più tempo di un singolo **SBA**, il numero totale di accessi è molto più basso.

---
### ESEMPIO
![[primary file organization.png]]
**Sequential file:**

- **Capacità bucket (CAP)** = **2** record per blocco

```powershell
FILE SEQUENTIAL # Ordine crescente
|
├─ Blocco 1 [Header: num_records=2]
|  ├─ Record: 101, Giulio, Informatica
|  └─ Record: 104, Andrea, Informatica
|
├─ Blocco 2 [Header: num_records=2]
|  ├─ Record: 208, Riccardo, Lamentologia
|  └─ Record: 325, Serena, Pianto
|
└─ Blocco 3 [Header: num_records=1]
   └─ Record: 416, Simone, Psicologia
```

---
