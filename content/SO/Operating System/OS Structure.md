Un sistema operativo è un software complesso che deve gestire molteplici risorse (CPU, memoria, dispositivi di I/O, processi). Per questo motivo, **ogni sistema operativo dovrebbe essere progettato come una partizione in sottosistemi**, ciascuno con responsabilità ben definite, propri input e output e specifici requisiti di prestazioni. La scelta di come strutturare un sistema operativo influisce direttamente su **sicurezza, efficienza, manutenibilità, estensibilità e semplicità di sviluppo**. Nel tempo sono stati proposti diversi modelli architetturali.

---
### STRUTTURA SEMPLICE

Nella **struttura semplice** non esiste una vera suddivisione in sottosistemi e non vi è separazione tra **kernel mode** e **user mode**. Tutto il codice, incluso quello delle applicazioni, può accedere direttamente all’hardware. Un esempio storico è **MS-DOS**

---
### KERNEL MONOLITICO

Nella **struttura a kernel monolitico**, l’intero sistema operativo risiede ed opera in **kernel mode**, mentre i programmi utente lavorano in **user mode**. Il kernel include: gestione dei processi, gestione della memoria, file system, driver di dispositivo, gestione dell’I/O. Esempi classici sono: **UNIX** o **Linux** (monolitico modulare).

---
### STRUTTURA A LIVELLI

Nella **struttura a livelli**, il sistema operativo è suddiviso in **N livelli gerarchici**. Ogni livello: utilizza esclusivamente i servizi del livello inferiore (n − 1) e fornisce nuove funzionalità al livello superiore (n + 1). Struttura prevalentemente utilizzata a **scopo didattico**.

---
### MICROKERNEL

Nella **struttura a microkernel**, il kernel contiene solo le funzionalità strettamente essenziali, come: gestione dei processi di base, gestione della memoria minima, comunicazione tra processi (IPC). Tutte le altre funzionalità del sistema operativo (file system, driver, servizi di rete) vengono eseguite in **user mode**, come processi separati. Un esempio classico è **MINIX**.

---
### MODULI DEL KERNEL CARICABILI

La struttura a **Loadable Kernel Modules (LKM)** è un’evoluzione del kernel monolitico. Il kernel fornisce un nucleo centrale, ma: alcune funzionalità (come driver o file system) sono implementate come **moduli caricabili** che possono essere caricati o rimossi **a runtime**, senza riavviare il sistema Une esempio classico è **Linux** (driver caricabili a runtime).

---
### KERNEL IBRIDO

Il **kernel ibrido** combina caratteristiche del **kernel monolitico** e del **microkernel**. In questo modello molte componenti sono organizzate in modo modulare e alcune funzionalità tipicamente da microkernel sono mantenute in kernel mode per migliorare le prestazioni. Esempi classici sono **Windows NT** (Windows 10/11) e **XNU** (macOS, iOS).

---
