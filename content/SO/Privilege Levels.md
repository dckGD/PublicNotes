Le CPU moderne implementano un sistema di **livelli di privilegio** che serve a proteggere il sistema operativo dai programmi utente e a impedire che un’applicazione possa eseguire istruzioni pericolose o accedere direttamente all’hardware. Questa protezione è fondamentale per garantire stabilità, sicurezza e isolamento tra i processi.

> Alcune istruzioni della CPU sono considerate **istruzioni privilegiate**, perché possono ad esempio arrestare la CPU (`HLT`) o generare interrupt (`INT x`). Se un programma utente potesse eseguirle liberamente, potrebbe: bloccare il sistema, leggere o modificare dati di altri processi, compromettere la sicurezza o prendere il controllo dell’hardware. Per questo motivo la CPU deve distinguere tra **codice di sistema operativo** e **codice utente**.

---
### MODALITA' OPERATIVE

Le CPU moderne usano principalmente **due modalità operative**, controllate da un bit speciale chiamato **mode bit**. il passaggio tra le due modalità avviene tramite [[Trap|trap]] di sistema.

---
#### Kernel mode 

È la modalità in cui gira il **sistema operativo**. In questa modalità la CPU può:

- eseguire tutte le istruzioni, incluse quelle privilegiate
- accedere a qualsiasi indirizzo di memoria
- comunicare direttamente con l’hardware
- gestire interrupt e trap
- cambiare la modalità della CPU

È la modalità con **massimo privilegio**, **mode bit = 0**.

---
#### User mode 

È la modalità in cui girano **tutte le applicazioni utente**. In questa modalità **non è possibile**:

- eseguire istruzioni privilegiate
- accedere direttamente ai dispositivi di I/O
- modificare memoria che non appartiene al processo
- cambiare autonomamente la modalità della CPU
- interferire con il kernel

È la modalità con **minimo privilegio**, **mode bit = 1**.

---
#### Privilege Levels (livelli di privilegio)
![[protection rings.png]]
Le [[Computer Architecture|architetture]] moderne possono prevedere più livelli di privilegio oltre alle due modalità classiche (kernel e user). Ad esempio, [[RISC-V|RISC‑V]] definisce tre modalità hardware ([[RISC-V Privilege Levels|M/S/U]]) con diversi livelli di accesso. Tuttavia, la maggior parte dei sistemi operativi utilizza solo due livelli: uno privilegiato per il kernel e uno non privilegiato per le applicazioni.

---



