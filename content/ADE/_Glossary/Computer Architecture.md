Importante è distinguere tra architetture e microarchitetture, che spesso vengono confuse ma descrivono aspetti della [[CPU]] completamente differenti.

---
### ARCHITETTURA

L’**architettura del calcolatore**, più precisamente **Instruction Set Architecture ([[ISA]])**, definisce **che cosa una CPU è in grado di fare** e come l'utente può comunicare con essa (es. x86-64, ARMv8, RISC-V). Un programma compilato per una ISA può girare su qualunque CPU (con qualsiasi microarchitettura) che implementi quella ISA.

---
#### Cosa definisce

- **[[Instructions Set|Set di istruzioni]]** 
- **[[Registers|Registri visibili al software]]**
- **[[Instruction Formats|Formati delle istruzioni]]**
- **[[Addressing Modes|Modalità di indirizzamento]]**
- **[[Virtual Memory|Modello di memoria]]**

---
### MICROARCHITETTURA

La **microarchitettura** descrive **come l’ISA viene implementata fisicamente** all’interno della CPU (es. Core e Zen).

---
#### Cosa definisce

- **[[Datapath|Organizzazione interna della CPU]]**
- **[[Datapath Pipeline|Pipeline (numero di stadi)]]** 
- **[[Cache|Cache (livelli, dimensioni)]]**
- **[[Execution Steps|Esecuzione in ordine / fuori ordine]]**
- **[[CPU Units|Unità funzionali]]** 
- **[[Hazard|Gestione degli hazard]]**

---
### TABELLA DI CONFRONTO

|Aspetto|Architettura (ISA)|Microarchitettura|
|---|---|---|
|Livello|Astratto|Fisico|
|Visibile al software|Sì|No|
|Definisce|_Cosa_ fa la CPU|_Come_ lo fa|
|Cambia nel tempo|Raramente|Spesso|
|Impatto|Compatibilità|Prestazioni|
 
---

