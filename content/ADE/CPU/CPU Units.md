In un'architettura **RISC-V**, la **CPU** è composta da diverse **unità funzionali** che collaborano per eseguire istruzioni. Ecco una panoramica delle principali unità:

---
### CU (Control Unit)

**Ruolo:** Coordina l'esecuzione delle istruzioni.  

- Decodifica l'istruzione prelevata dalla memoria.  
- Genera segnali di controllo per le altre unità.  
- Gestisce i cambi di flusso (salti e branch). 

---
### ALU (Arithmetic Logic Unit)

**Ruolo:** Esegue operazioni aritmetiche e logiche.  

- Addizione, sottrazione (`add`, `sub`)  
- Operazioni logiche (`and`, `or`, `xor`)  
- Shift e rotazioni (`sll`, `srl`, `sra`)  
- Confronti (`slt`, `sltu`) 

---
### FPU (Floating Point Unit)

**Ruolo:** Esegue operazioni su numeri in virgola mobile.  

- Somma, sottrazione, moltiplicazione, divisione (`fadd.s`, `fmul.s`).  
- Conversioni tra interi e float (`fcvt.s.w`).  
- Comparazioni (`flt.s`, `feq.s`).

--- 
### IFU (Instruction Fetch Unit)

**Ruolo:** Preleva le istruzioni dalla memoria.  
 
- Carica l'istruzione successiva dal Program Counter (PC).  
- Passa l'istruzione alla **Unità di Decodifica**.  
- Predice i salti (`branch predictor`). 

---
### IDU (Instruction Decode Unit)

**Ruolo:** Interpreta l'istruzione e attiva le unità necessarie.  

- Identifica il tipo di istruzione (aritmetica, memoria, branch, FPU).  
- Controlla quali registri sono coinvolti.  
- Imposta segnali per la **ALU, FPU, Load/Store Unit**.

---
### LSU (Load/Store Unit)

**Ruolo:** Gestisce il trasferimento di dati tra registri e memoria.  

- Caricamento dati (`lw`, `lb`, `ld`).  
- Memorizzazione dati (`sw`, `sb`, `sd`).  
- Accesso alla memoria cache. 

---
### BU (Branch Unit)

**Ruolo:** Gestisce i salti condizionali e incondizionati.  

- Confronta i registri (`beq`, `bne`, `blt`).  
- Aggiorna il **Program Counter (PC)** in caso di salto.  
- Lavora con il **Branch Predictor** per ottimizzare le prestazioni.

---
### CSRU (Control and Status Registers Unit)

**Ruolo:** Gestisce registri speciali della CPU.  

- Controlla eccezioni e interrupt (`mstatus`, `mepc`).  
- Gestisce la modalità privilegiata (`mcause`, `mie`).  
- Abilita la FPU e altre estensioni (`misa`).

---
### MMU (Memory Management Unit)

**Ruolo:** Controlla l'accesso alla memoria principale e virtuale.  

- Gestisce la **memoria virtuale** e la traduzione degli indirizzi virtuali in fisici.
- Controlla i permessi di accesso alla memoria. 

---
