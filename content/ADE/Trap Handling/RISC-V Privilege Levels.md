L’architettura RISC‑V definisce **tre modalità di privilegio hardware**, una in più rispetto ad allo [[Privilege Levels|standard]]. Le modalità definite da RISC-V sono:

---
### MACHINE MODE (M-MODE)

È la modalità con **massimo privilegio**, in cui opera il [[Firmware|firmware]].

**Responsabilità:**

- inizializzazione dell’hardware
- configurazione delle trap e delega verso S‑mode
- gestione dei timer e interrupt a livello macchina
- gestione dei CSR di livello Machine
- passaggio al Supervisor mode

**Accesso:**

- a **tutti** i [[CSR Registers|registri CSR]]
- alla memoria fisica senza restrizioni
- a tutte le istruzioni privilegiate

---
### SUPERVISOR MODE (S-MODE)

È la modalità in cui opera il **kernel del sistema operativo**.

**Responsabilità:**

- gestione della [[Virtual Memory|memoria virtuale]]
- gestione delle [[Trap|trap]] tramite `stvec`, `sepc`, `scause`, `stval`
- gestione dei processi in U‑mode
- gestione delle system call (`ecall` da U‑mode)
- gestione dei driver

**Accesso:**

- ai CSR di livello Supervisor
- alle istruzioni privilegiate necessarie al kernel
- alla memoria virtuale del kernel

---
### USER MODE (U-MODE)

È la modalità con **minimo privilegio**.

**Caratteristiche:**

- esecuzione delle applicazioni utente
- accesso limitato ai registri generali (`x0–x31`)
- accesso alla **propria** memoria virtuale
- nessun accesso diretto all’hardware
- nessuna istruzione privilegiata

**Può generare trap tramite:**

- `ecall` → richiesta di system call
- `ebreak` → breakpoint per debugger

---