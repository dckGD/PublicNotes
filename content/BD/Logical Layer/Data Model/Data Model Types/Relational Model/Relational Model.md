Il **modello relazionale** è il modello di dati più diffuso nei moderni sistemi di gestione di database. È stato proposto da **Edgar F. Codd** nel 1970 e si basa sulla rappresentazione dei dati attraverso **tabelle** (dette relazioni), che consentono un’organizzazione semplice, coerente e indipendente dall’applicazione.

---
### STRUTTURA DI BASE

I **dati** sono memorizzati in **tabelle** (_relazioni_).
Ogni **riga** della tabella è un **record** (_tupla_).
Ogni **colonna** rappresenta un **attributo** con un nome e un tipo di dato.
Le tabelle possono essere collegate tra loro tramite **chiavi**.

---
### ESEMPIO: 

![[relational model.png]]

---
### ELEMENTI FONDAMENTALI

Gli elementi fondamentali di una tabella relazionale sono:

---
#### Schema

È la **struttura logica** della tabella, cioè l'insieme dei suoi attributi.  

**Esempio:**  
![[relation schema.png]]

**Esami(Studente, Voto, Corso)** → definisce la struttura di base della relazione.

---
#### Istanza

È il **contenuto attuale** della tabella, cioè l’insieme delle **righe (tuple)** presenti in un certo momento. 

**Esempio:**
![[relation instance.png]]
Cambia nel tempo, mentre lo **schema resta fisso**.

---
#### Tupla

È una **riga** della tabella. Rappresenta un **singolo record** o un’**occorrenza** di dati secondo lo schema.

**Esempio:**
![[relation tuple.png]]`(101, 19, 01)` è una tupla.

---
#### Attributo

È una **colonna** della tabella. Definisce una **proprietà** o **caratteristica** delle entità rappresentate.

**Esempio:**
![[relation attribute.png]]
**Voto** è un attributo dello schema **Esami**.

---
#### Chiave

Le **chiavi** sono **attributi o insiemi di attributi** che servono a **identificare e collegare** in modo univoco i dati in un database relazionale. Sono alla base dell’[[Database#Integrità (integrity)|integrità]] e delle relazioni tra tabelle.

---
##### Chiave primaria (primary key)

Identifica **in modo univoco ogni tupla** di una tabella.

- Non può essere **NULL**.
- Non può avere **duplicati**.
- È la chiave **principale** scelta tra le possibili chiavi candidate.

**Esempio:**  

**Studenti(Matricola, Nome, Cognome)** → **Matricola** è **primary key**.

---
##### Chiave candidata

È **qualsiasi insieme di attributi** che potrebbe fungere da chiave primaria.

- Tutte le chiavi candidate sono **minimali, univoche** e **non nulle**.
- Una sola viene scelta come **chiave primaria**, le altre restano **candidate**.

**Esempio:**  

**Corsi(Codice, Titolo, Tutor)** → sia **Codice** che **Titolo** sono chiavi candidate.

---
##### Chiave composta (o concatenata)

È una chiave **formata da più attributi** insieme. Serve quando un singolo attributo non basta a identificare una tupla.

**Esempio:**  

**Iscrizioni(Matricola, Corso, Data)** → la chiave può essere **(Matricola, Corso)**.

---
##### Chiave esterna (foreign key)

È un attributo che **fa riferimento alla chiave primaria di un’altra tabella**. Serve a creare **relazioni tra tabelle** e garantire **integrità referenziale**.

**Esempio:**

**Studenti(Matricola, Nome, Cognome)** e **Esami(Matricola, Voto, Corso)** → **Matricola** in **Esami** è **foreign key** che punta a **Matricola** in **Studenti**.

---
##### Superchiave

È **qualsiasi insieme di attributi** che identifica in modo univoco le tuple, anche se contiene attributi superflui. Se **K** è una chiave, allora ogni insieme di attributi **S ⊇ K** è una superchiave.

- Tutte le chiavi candidate e primarie **sono superchiavi**.
- Non tutte le superchiavi **sono minimali** (possono contenere attributi inutili).

**Esempio:**  

L'insieme di attributi **(Matricola, Nome)** è superchiave se **Matricola** è già unica.

---
#### Cardinalità

È il **numero di tuple (righe)** presenti nella tabella in un certo momento.  

**Esempio:** 
![[relation cardinality.png]]
Se ci sono 3 esami → **cardinalità = 3**.

---
#### Grado

È il **numero di attributi (colonne)** definiti nello schema.  

**Esempio:** 
![[relation grade.png]]
In **Esami(Studente, Voto, Corso)** → **grado = 3**.

---
#### Valori e NULL

Ogni **valore** è un elemento effettivo di una tupla, preso dal **dominio** dell’attributo (cioè l’insieme dei valori ammessi). Una relazione non può presentare campi vuoti, quindi, in assenza di darti, si utilizza il valore polimorfo **NULL**..

**Esempio:**
![[relation value.png]]
Il **valore NULL** indica _assenza di informazione_: valore sconosciuto, non applicabile, o non disponibile. **NULL** **non è zero né stringa vuota**, ma una condizione logica speciale che significa “nessun valore”.

---
### PROPRIETA'

**Indipendenza logica e fisica dei dati**: le applicazioni non dipendono dalla struttura fisica dei dati.
**Integrità dei dati**: garantita tramite **[[Database#Vincoli di integrità|vincoli]]** (es. chiavi, domini, relazioni).
**Operazioni matematiche definite**: basato sulla **[[Relations|teoria degli insiemi]]** e sull’**[[Relational Algebra|algebra relazionale]]**.
**Accesso ai dati con [[SQL|linguaggi dichiarativi]]**, come **SQL**, che specificano _cosa_ ottenere, non _come_.

---

**Vantaggi:**

- Semplicità concettuale: i dati appaiono come tabelle intuitive.
- Indipendenza tra struttura logica e implementazione fisica.
- Elevata flessibilità: relazioni molti-a-molti gestite con tabelle intermedie.
- Sicurezza, consistenza e integrità dei dati garantite dai vincoli.
- Facilità d’interrogazione e aggiornamento con SQL.    

**Svantaggi:**

- Prestazioni inferiori ai modelli [[Hierarchical Model|gerarchico]] o [[Mesh Model|reticolare]] per accessi molto frequenti e ripetitivi.
- Rigidità in applicazioni che richiedono strutture di dati molto complesse o gerarchie profonde.
- Necessità di normalizzazione per evitare ridondanze (processo che può aumentare la complessità logica).

---