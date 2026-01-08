[[RISC-V]] è un'architettura **modulare**, il che significa che è costituita da un **set base di istruzioni** a cui si possono aggiungere **estensioni opzionali** per supportare funzionalità specifiche. 

---
### SET DI BASE

Ogni implementazione RISC-V deve supportare almeno uno dei seguenti set base:

- **RV32I** → Set di istruzioni **Intero** a 32 bit.
- **RV64I** → Set di istruzioni **Intero** a 64 bit.
- **RV128I** → Set di istruzioni **Intero** a 128 bit (sperimentale).

Le versioni base (**I = Integer**) includono [[Instructions Set|operazioni]] aritmetiche, logiche, di controllo di flusso, load/store e gestione del salto.

---
### ESTENSIONI STANDARD

Le estensioni standard sono definite dalla RISC-V Foundation e aggiungono funzionalità specializzate.

| **Estensione**                                                   | **Descrizione**                                                                                                              |
| ---------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| [[Instructions Set#ESTENSIONE M\|M]] (Multiplication)            | Aggiunge istruzioni per la moltiplicazione e divisione intera (`MUL`, `DIV`, `REM`).                                         |
| **[[Instructions Set#ESTENSIONE A\|A]] **(Atomic)                | Introduce istruzioni atomiche (`LR/SC`, `AMOSWAP`, `AMOADD`...) utili per la sincronizzazione nei sistemi multiprocessore.   |
| **[[Instructions Set#ESTENSIONE F\|F]]** (Floating-Point)        | Supporto per numeri in virgola mobile a precisione singola (32 bit, IEEE 754).                                               |
| **[[Instructions Set#ESTENSIONE D\|D]]** (Double Floating-Point) | Supporto per numeri in virgola mobile a doppia precisione (64 bit, IEEE 754).                                                |
| **[[Instructions Set#ESTENSIONE C\|C]]** (Compressed)            | Aggiunge istruzioni **compatte a 16 bit**, riducendo il consumo di memoria e migliorando l'efficienza energetica.            |
| **Zicsr** (Control and Status Register)                          | Gestione dei registri CSR (usati per configurazione e gestione delle eccezioni).                                             |
| **Zifencei** (Instruction-Fetch Fence)                           | Sincronizzazione tra accessi alla memoria e fetch delle istruzioni (importante per la coerenza nei processori con pipeline). |
L'estensione **G** (General purpose) include tutte le estensioni standard.

---