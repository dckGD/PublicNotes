L'esecuzione di un'istruzione in un processore RISC-V avviene in un ciclo di **6 fasi principali**. Ognuna di queste fasi è associata a una o più unità specifiche della CPU che svolgono un ruolo essenziale nel completamento dell'operazione. Le fasi sono:

---
### 1. (IF) FETCH 

**Caricamento dell'istruzione**: 

L'**istruzione** da eseguire viene **prelevata** dalla **memoria** (nella **sezione testo della RAM**) all'indirizzo indicato dal [[Program Counter|program counter]] (PC), attraverso l'[[CPU Units#IFU (Instruction Fetch Unit)|IFU]].

---
### 2. (ID) DECODE

**Riconoscimento dell'istruzione**: 

Una volta che l'istruzione è stata caricata, viene **decodificata** dalla [[CPU Units#IDU (Instruction Decode Unit)|IDU]]. La [[CPU Units#CU (Control Unit)|Control Unit]] interpreta quindi la decodifica fatta dall'IDU e **decide quali parti del processore** (come l'ALU, i registri, la memoria, ecc.) devono essere attivate per eseguire l'istruzione.

La [[Instruction Formats|codifica]] della istruzione deve indicare: 

- Quale operazione va svolta ([[Opcode]]).
- Quali argomenti sono necessari.
- Dove mettere il risultato.

**In questa fase si raccolgono i dati per l'indirizzamento**: L'indirizzamento dei dati può avvenire in [[Addressing Modes|diversi modi]] in base al formato dell'istruzione. A seconda del tipo di indirizzamento, si leggono **registri sorgente** e/o **valori immediati** (come l'offset), che serviranno nella fase successiva.

---
### 3. (EX) EXECUTE

**Esecuzione dell'istruzione/indirizzamento**: 

L'[[CPU Units#ALU (Arithmetic Logic Unit)|ALU]], insieme eventualmente alla [[CPU Units#FPU (Floating Point Unit)|FPU]] o alla [[CPU Units#BU (Branch Unit)|BU]], esegue il calcolo o l’operazione logica indicata dall’istruzione.

- Per operazioni aritmetiche o logiche (`add`, `sub`, `and`, `or` ecc.), l’ALU esegue direttamente il calcolo.
- Per istruzioni di trasferimento dati (`lw`, `sw`), l’ALU **calcola l’indirizzo di memoria** usando i dati raccolti in Decode.

**In questa fase avviene l’indirizzamento vero e proprio**: Viene calcolato l’**indirizzo effettivo** (es. `rs1 + offset`) a cui accedere in memoria.

---
### 4. (MEM) MEMORY

**Accesso alla memoria RAM**: 

Solo per istruzioni che coinvolgono la **memoria dati** (`sw`, `lw` ecc.):
- Se è una `load`, la [[CPU Units#LSU (Load/Store Unit)|LSU]] legge dalla RAM all’indirizzo calcolato.
- Se è una `store`, la LSU scrive nella RAM il valore di un registro.

---
### 5. (WB) WRITE BACK

**Scrittura nei registri della CPU**: 

Questa fase si applica solo alle istruzioni che **producono un valore da salvare in un registro** (`add`, `sub`, `lw`, `andi`, `mul`, ecc.). Il valore può provenire dall’ALU (aritmetica) o dalla RAM (load).

---
### 6. (AGGIORNAMENTO DEL PC)

**Aggiornamento del Program Counter**: 

Il [[Program Counter|program counter]] viene aggiornato dalla [[CPU Units#CU (Control Unit)|CU]] al termine di ogni ciclo di esecuzione per puntare all'indirizzo dell'istruzione successiva. Se l'istruzione è un **salto** o un **branch**, il PC potrebbe essere aggiornato con un nuovo indirizzo dalla [[CPU Units#BU (Branch Unit)|BU]], cambiando il flusso di esecuzione del programma.

---