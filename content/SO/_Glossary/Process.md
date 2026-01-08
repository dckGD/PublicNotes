Un **processo** è un’**istanza attiva** di un [[Program|programma]]: si avvia quando il programma viene **caricato in memoria principale (RAM)** e le sue istruzioni vengono **eseguite dalla CPU**.

**Caratteristiche principali:**

- È dinamico
- Ha uno **stato** (registri, program counter, stack, heap, ecc.)
- Più processi possono derivare dallo **stesso programma**, ma sono **indipendenti**

**Esempio:** aprire due volte lo stesso browser crea **due processi distinti**.

---
### STATO DI UN PROCESSO

Ogni processo possiede uno stato proprio, che include:

- valore dei registri
- area di memoria allocata
- file aperti
- stato di esecuzione (running, ready, waiting, ecc.)

Questo permette al sistema operativo di **sospendere e riprendere** un processo.

---