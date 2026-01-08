Gli [[Hazard|hazard]] possono essere identificati attraverso la lettura dei registri della pipeline.

---
### IDENTIFICAZIONE DI DATA HAZARD (FORWARDING)

Ad ogni ciclo di clock nei registri della pipeline vengono memorizzati/letti: registri, immediati, segnali e valori intermedi (calcolati con ALU o presi dalla memoria). Ogni istruzione memorizzata in uno dei registri della pipeline è quindi un record con più campi, ad esempio:

```assembly
sub x2, x1, x3  
```

corrisponde al seguente record in ID/EX:

```r
ID/EX = {
    RegisterRs1: 1,           # x1 (sorgente 1)
    RegisterRs2: 3,           # x3 (sorgente 2)
    RegisterRd: 2,            # x2 (destinazione)
    ReadData1: 7,             # valore contenuto in x1
    ReadData2: 27,            # valore contenuto in x3
    Immediate: 0,             # non serve per tipo R (ignorato)
    ALUSrc: 0,                # usa rs2, non l’immediato
    ALUOp: 10,                # tipo R → serve la ALU Control Unit
    MemRead: 0,               # non legge dalla memoria
    MemWrite: 0,              # non scrive nella memoria
    RegWrite: 1,              # scrive in x2 (registro)
    MemToReg: 0,              # risultato viene dalla ALU
    funct3: 000,              # comune ad add/sub
    funct7: 0100000,          # specifico per sub
    opcode: 0110011,          # tipo R
}
```

Tutti questi campi vengono dunque **copiati dentro il registro di pipeline ID/EX** e usati nel ciclo successivo, nello stadio [[Execution Steps#3. (EX) EXECUTE|EX]]. La visione di questi record permette l'utilizzo di una notazione accurata per accedere ad ogni campo:

Durante la fase [[Execution Steps#2. (ID) DECODE|ID]]:

`rs1 = 2` → salvato in `ID/EX.RegisterRs1`
`rs2 = 3` → salvato in `ID/EX.RegisterRs2`
`rd = 5` → salvato in `ID/EX.RegisterRd`
`RegWrite = 1` → salvato in `ID/EX.RegWrite`
`...` e così via per ognuno dei campi visti sopra.

Utilizzando questa notazione (e sapendo che l'ALU ha due input [[Datapath Single-Cycle#^41b6e9|a, b]]) posso esprimere le due coppie di casi di hazard in EX così: 

| **Hazard** | **Quando lo rilevo**                                                      | **Condizione formale**                   |
| ---------- | ------------------------------------------------------------------------- | ---------------------------------------- |
| **1.a**    | RAW su **rs1** con l’istruzione **immediatamente precedente** (in EX/MEM) | `ID/EX.RegisterRs1 == EX/MEM.RegisterRd` |
| **1.b**    | RAW su **rs2** con l’istruzione **immediatamente precedente** (in EX/MEM) | `ID/EX.RegisterRs2 == EX/MEM.RegisterRd` |
| **2.a**    | RAW su **rs1** con l’istruzione di **due cicli prima** (in MEM/WB)        | `ID/EX.RegisterRs1 == MEM/WB.RegisterRd` |
| **2.b**    | RAW su **rs2** con l’istruzione di **due cicli prima** (in MEM/WB)        | `ID/EX.RegisterRs2 == MEM/WB.RegisterRd` |
>Ad ognuno dei casi sopra vanno aggiunte le condizioni:
>`EX/MEM.RegWrite == 1`: in quanto, se non si trattasse di un'istruzione che va a scrivere nel [[Datapath Single-Cycle#Register File|register file]], allora non ci sarebbe bisogno di forwarding in quanto non ci sarebbero valori da inoltrare in ID/EX.
>`EX/MEM.RegisterRd ≠ 0`: in quanto in RISC-V, **x0 è sempre zero** e ogni tentativo di scriverci **non ha effetto**.

---
### IDENTIFICAZIONE DI LOAD-USE HAZARD

Ad ogni ciclo di clock nei registri della pipeline vengono memorizzati/letti: registri, immediati, segnali e valori intermedi (calcolati con ALU o presi dalla memoria). Ogni istruzione memorizzata in uno dei registri della pipeline è quindi un record con più campi, ad esempio:

```assembly
lw x2, 20(x1)                 # 20(x1) = 10
```

corrisponde al seguente record in ID/EX:

```r
ID/EX = {
    RegisterRs1: 1,           # x1 (sorgente per l'indirizzo)
    RegisterRs2: -,           # NON usato
    RegisterRd: 2,            # x2 (destinazione del dato letto)
	ReadData1: 10,            # valore di x1, letto dal file di registri
    ReadData2: -,             # non usato (nessun secondo registro)
    Immediate: 20,            # offset imm (esteso a 32 bit)
    ALUSrc: 1,                # ALU usa l'immediato (rs1 + offset)
    ALUOp: 00,                # ALU deve sommare → indirizzo
    MemRead: 1,               # legge dalla memoria dati
    MemWrite: 0,              # non scrive nella memoria
    RegWrite: 1,              # scrive nel file di registri (x2)
    MemToReg: 1,              # risultato proviene dalla memoria
    funct3: 010,              # tipo load word (lw)
    funct7: -,                # non usato per istruzioni I-type
    opcode: 0000011           # opcode delle istruzioni di load
}
```

Tutti questi campi vengono dunque **copiati dentro il registro di pipeline ID/EX** e usati nel ciclo successivo, nello stadio [[Execution Steps#3. (EX) EXECUTE|EX]]. La visione di questi record permette l'utilizzo di una notazione accurata per accedere ad ogni campo:

Durante la fase [[Execution Steps#1. (IF) FETCH|IF]]:

`rd = 2` → salvato in `IF/ID.RegisterRd`

Durante la fase [[Execution Steps#2. (ID) DECODE|ID]]:

`rs1 = 1` → salvato in `ID/EX.RegisterRs1`
`MemRead = 1` → salvato in `ID/EX.MemRead`
`...` e così via per ognuno dei campi visti sopra.

Utilizzando questa notazione posso esprimere il caso di hazard load-use con le seguenti condizioni: 

| **Hazard**   | **Quando lo rilevo**                                                                                            | **Condizione formale**                                                           |
| ------------ | --------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- |
| **Load‑Use** | **Speciale RAW**: stallo necessario quando un `lw` è **subito** prima dell’uso e il dato non è ancora in EX/MEM | `ID/EX.RegisterRs1 == IF/ID.RegisterRd OR ID/EX.RegisterRs2 == IF/ID.RegisterRd` |
>A questo caso vanno aggiunte le seguenti condizioni:
>`ID/EX.MemRead == 1`: indica che **l’istruzione attualmente in `ID/EX` è una `lw`** e quindi il suo risultato **non sarà disponibile prima del MEM**.
>`IF/ID.RegisterRd ≠ 0`: in quanto in RISC-V, **x0 è sempre zero** e ogni tentativo di scriverci **non ha effetto**.

---

