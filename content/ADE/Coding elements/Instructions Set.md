### SET BASE

Le istruzioni del set base definiscono le operazioni fondamentali per il calcolo, il controllo del flusso e l’accesso alla memoria.

---
#### OPERAZIONI ARITMETICHE E LOGICHE
##### Operazioni sui Registri ([[Instruction Formats#1. FORMATO R (REGISTER-REGISTER)|Formato R]])

**ADD**  
_Sintassi_: `add rd, rs1, rs2`  
_Descrizione_: Somma `rs1` e `rs2` → `rd = rs1 + rs2`  
_Esempio_:

```assembly
add x5, x1, x2  # x5 = x1 + x2
```

---

**SUB**  
_Sintassi_: `sub rd, rs1, rs2`  
_Descrizione_: Sottrae `rs2` da `rs1` → `rd = rs1 - rs2`  
_Esempio_:

```assembly
sub x5, x1, x2  # x5 = x1 - x2
```

---

**SLL** (Shift Left Logical)  

_Sintassi_: `sll rd, rs1, rs2`  
_Descrizione_: Shifta a sinistra `rs1` di un numero di bit specificato da `rs2`  
_Esempio_:

```assembly
sll x5, x1, x2  # x5 = x1 << (rs2)
```

---

**SLT** (Set Less Than, signed)  

_Sintassi_: `slt rd, rs1, rs2`  
_Descrizione_: Se `rs1` < `rs2` (con segno) allora `rd = 1`, altrimenti 0  
_Esempio_:

```assembly
slt x5, x1, x2  # x5 = (x1 < x2) ? 1 : 0
```

---

**SLTU** (Set Less Than, unsigned)  

_Sintassi_: `sltu rd, rs1, rs2`  
_Descrizione_: Confronto senza segno  
_Esempio_:

```assembly
sltu x5, x1, x2  # x5 = (x1 < x2) in unsigned ? 1 : 0
```

---

**XOR**  

_Sintassi_: `xor rd, rs1, rs2`  
_Descrizione_: Operazione bitwise XOR tra `rs1` e `rs2`  
_Esempio_:

```assembly
xor x5, x1, x2  # x5 = x1 ^ x2
```

---

**SRL** (Shift Right Logical)  

_Sintassi_: `srl rd, rs1, rs2`  
_Descrizione_: Shift logico a destra  
_Esempio_:

```assembly
srl x5, x1, x2  # x5 = x1 >> (rs2) (riempimento con 0)
```

---

**SRA** (Shift Right Arithmetic)  

_Sintassi_: `sra rd, rs1, rs2`  
_Descrizione_: Shift aritmetico a destra (mantiene il segno)  
_Esempio_:

```assembly
sra x5, x1, x2  # x5 = x1 >> (rs2) preservando il bit del segno
```

---

**OR**  

_Sintassi_: `or rd, rs1, rs2`  
_Descrizione_: Operazione bitwise OR  
_Esempio_:

```assembly
or x5, x1, x2  # x5 = x1 | x2
```

---

**AND**  

_Sintassi_: `and rd, rs1, rs2`  
_Descrizione_: Operazione bitwise AND  
_Esempio_:

```assembly
and x5, x1, x2  # x5 = x1 & x2
```

---

##### Operazioni con Immediati ([[Instruction Formats#2. FORMATO I (IMMEDIATE-REGISTER)|Formato I]])

**ADDI**  

_Sintassi_: `addi rd, rs1, imm`  
_Descrizione_: Somma il registro `rs1` con un valore immediato  
_Esempio_:

```assembly
addi x5, x1, 10  # x5 = x1 + 10
```

---

**SLTI**  

_Sintassi_: `slti rd, rs1, imm`  
_Descrizione_: Imposta `rd = 1` se `rs1` è minore di `imm` (signed)  
_Esempio_:

```assembly
slti x5, x1, 20  # x5 = (x1 < 20) ? 1 : 0
```

---

**SLTIU**  

_Sintassi_: `sltiu rd, rs1, imm`  
_Descrizione_: Confronto senza segno con immediato  
_Esempio_:

```assembly
sltiu x5, x1, 20  # confronto unsigned
```

---

**XORI**  

_Sintassi_: `xori rd, rs1, imm`  
_Descrizione_: XOR tra `rs1` e l’immediato  
_Esempio_:

```assembly
xori x5, x1, 0xFF
```

---

**ORI**  

_Sintassi_: `ori rd, rs1, imm`  
_Descrizione_: OR bitwise con immediato  
_Esempio_:

```assembly
ori x5, x1, 0xF0
```

---

**ANDI**  

_Sintassi_: `andi rd, rs1, imm`  
_Descrizione_: AND bitwise con immediato  
_Esempio_:

```assembly
andi x5, x1, 0x0F
```

---

**SLLI**  

_Sintassi_: `slli rd, rs1, shamt`  
_Descrizione_: Shift logico a sinistra con immediato di shift (shamt) 
_Esempio_:

```assembly
slli x5, x1, 3  # x5 = x1 << 3
```

---

**SRLI / SRAI**  

_Sintassi_: `srli rd, rs1, shamt` e `srai rd, rs1, shamt`  
_Descrizione_: Shift logico o aritmetico a destra con immediato  
_Esempio_:

```assembly
srli x5, x1, 2  # x5 = x1 >> 2 (logical) 
srai x5, x1, 2  # x5 = x1 >> 2 (arithmetic)
```

---
##### Operazioni Speciali ([[Instruction Formats#5. FORMATO U (UPPER IMMEDIATE)|Formato U]])

**LUI** (Load Upper Immediate)  

_Sintassi_: `lui rd, imm20`  
_Descrizione_: Carica un immediato di 20 bit nella parte alta del registro (il resto viene posto a 0)  
_Esempio_:

```assembly
lui x5, 0x12345  # x5 = 0x12345000
```

---

**AUIPC** (Add Upper Immediate to PC)  

_Sintassi_: `auipc rd, imm20`  
_Descrizione_: Calcola `rd = PC + (imm20 << 12)`  
_Esempio_:

```assembly
auipc x5, 0x1  # x5 = PC + 0x1000
```

---
#### CONTROLLO DI FLUSSO

##### Branch (Salti condizionati - [[Instruction Formats#4. FORMATO B (BRANCH)|Formato B]])

**BEQ**  

_Sintassi_: `beq rs1, rs2, offset`  
_Descrizione_: Salta se `rs1 == rs2`  
_Esempio_:

```assembly
beq x1, x2, label
```

---

**BNE**  

_Sintassi_: `bne rs1, rs2, offset`  
_Descrizione_: Salta se `rs1 != rs2`  
_Esempio_:

```assembly
bne x1, x2, label
```

---

**BLT** e **BGE** (signed)  

_Sintassi_: `blt rs1, rs2, offset` / `bge rs1, rs2, offset`  
_Descrizione_: Salta se `rs1 < rs2` (signed) o se `rs1 >= rs2`  
_Esempio_:

```assembly
blt x1, x2, label  # se x1 < x2 
bge x1, x2, label  # se x1 >= x2
```

---

**BLTU** e **BGEU** (unsigned)  

_Sintassi_: `bltu rs1, rs2, offset` / `bgeu rs1, rs2, offset`  
_Descrizione_: Confronti senza segno  
_Esempio_:

```assembly
bltu x1, x2, label  # confronto unsigned 
bgeu x1, x2, label
```

---
##### Jump (Salti Incondizionati - [[Instruction Formats#6. FORMATO J (JUMP)|Formato J]])

**JAL** (Jump and Link)  

_Sintassi_: `jal rd, label`  
_Descrizione_: Salta a `label` e memorizza il return address in `rd`  
_Esempio_:

```assembly
jal x1, func  # x1 = PC + 4 *, salto a func
```
_\*(PC + 4 perché al ritorno della funzione si va ad eseguire l'istruzione successiva a quella memorizzata in x1)

---

**JALR** (Jump and Link Register)  

_Sintassi_: `jalr rd, imm(rs1)`  
_Descrizione_: Salto indiretto: calcola l’indirizzo target come `(rs1 + imm)`, salta all'indirizzo target e memorizza il return address in `rd`
_Esempio_:

```assembly
jalr x1, 0(x2)  # x1 = PC + 4, salto all'indirizzo contenuto in x2 + 0
```

---
#### ACCESSO ALLA MEMORIA

##### Istruzioni di Caricamento (Load – [[Instruction Formats#2. FORMATO I (IMMEDIATE-REGISTER)|Formato I]])

**LB, LH, LW**  

_Sintassi_: `lb rd, offset(rs1)`; analogamente per `lh` (halfword) e `lw` (word)  
_Descrizione_: Carica 8, 16 o 32 bit da memoria in segno esteso  
_Esempio_:

```assembly
lw x5, 0(x1)  # x5 = Mem[x1 + 0]
```

---

**LBU, LHU**  

_Sintassi_: `lbu rd, offset(rs1)`; `lhu` per halfword senza segno  
_Descrizione_: Carica il dato senza segno  
_Esempio_:

```assembly
lbu x5, 0(x1)
```

---
##### Istruzioni di Memorizzazione (Store –[[Instruction Formats#3. FORMATO S (STORE)|Formato S]])

**SB, SH, SW**  

_Sintassi_: `sb rs2, offset(rs1)`; analogamente per `sh` (halfword) e `sw` (word)  
_Descrizione_: Memorizza 8, 16 o 32 bit in memoria  
_Esempio_:

```assembly
sw x5, 0(x1)  # Mem[x1+0] = x5
```

---

##### Istruzioni di Sincronizzazione e Ambiente

**FENCE**  

_Sintassi_: `fence [pred], [succ]`  
_Descrizione_: Garantisce l’ordine delle operazioni di memoria  
_Esempio_:

```assembly
fence
```

---

**FENCE.I**  

_Sintassi_: `fence.i`  
_Descrizione_: Sincronizza le istruzioni cache (utile dopo modifiche alla memoria contenente codice)  
_Esempio_:

```assembly
fence.i
```

---

**ECALL** e **EBREAK**  

_Descrizione_: Chiamata al sistema (ECALL) ed interruzione per debug (EBREAK)  
_Esempio_:

```assembly
ecall ebreak
```

---
#### TABELLA RIASSUNTIVA - SET BASE

|Istruzione|Categoria|Descrizione breve|
|---|---|---|
|ADD|Aritmetica|Somma due registri|
|SUB|Aritmetica|Sottrazione tra registri|
|SLL|Shift|Shift logico a sinistra|
|SLT / SLTU|Confronto|Setta se minore (signed/unsigned)|
|XOR|Logica|XOR bitwise|
|SRL / SRA|Shift|Shift logico / aritmetico a destra|
|OR|Logica|OR bitwise|
|AND|Logica|AND bitwise|
|ADDI|Aritmetica|Somma con immediato|
|SLTI/SLTIU|Confronto|Set less than con immediato (signed/unsigned)|
|XORI, ORI, ANDI|Logica|Operazioni logiche con immediato|
|SLLI, SRLI, SRAI|Shift|Shift con immediato|
|LUI|Speciale|Carica immediato nella parte alta|
|AUIPC|Speciale|PC-relative address calcolo|
|JAL, JALR|Salti|Salti incondizionati con link|
|BEQ, BNE, BLT, BGE, BLTU, BGEU|Branch|Salti condizionati|
|LB, LH, LW, LBU, LHU|Caricamento|Caricamento dati da memoria|
|SB, SH, SW|Memorizzazione|Scrittura in memoria|
|FENCE, FENCE.I|Sincronizzazione|Controllo ordine memoria/instr.|
|ECALL, EBREAK|Ambiente|Chiamate di sistema e debug|

---

### ESTENSIONE M

Le istruzioni dell’estensione **M** aggiungono operazioni aritmetiche per la moltiplicazione e la divisione intera.

---

**MUL**  

_Sintassi_: `mul rd, rs1, rs2`  
_Descrizione_: Moltiplicazione a 32/64 bit (parte bassa del risultato)  
_Esempio_:

```assembly
mul x5, x1, x2  # x5 = (x1 * x2) lower part
```

---

**MULH**  

_Sintassi_: `mulh rd, rs1, rs2`  
_Descrizione_: Moltiplicazione che restituisce la parte alta del prodotto (signed)  
_Esempio_:

```assembly
mulh x5, x1, x2
```

---

**MULHSU**  

_Sintassi_: `mulhsu rd, rs1, rs2`  
_Descrizione_: Moltiplicazione tra un operando signed e uno unsigned, parte alta  
_Esempio_:

```assembly
mulhsu x5, x1, x2
```

---

**MULHU**  

_Sintassi_: `mulhu rd, rs1, rs2`  
_Descrizione_: Moltiplicazione unsigned, parte alta  
_Esempio_:

```assembly
mulhu x5, x1, x2
```

---

**DIV**  

_Sintassi_: `div rd, rs1, rs2`  
_Descrizione_: Divisione intera signed  
_Esempio_:

```assembly
div x5, x1, x2  # x5 = x1 / x2 (signed)
```

---

**DIVU**  

_Sintassi_: `divu rd, rs1, rs2`  
_Descrizione_: Divisione intera unsigned  
_Esempio_:

```assembly
divu x5, x1, x2  # divisione unsigned
```

---

**REM**  

_Sintassi_: `rem rd, rs1, rs2`  
_Descrizione_: Resto della divisione signed  
_Esempio_:

```assembly
rem x5, x1, x2  # x5 = x1 % x2 (signed)
```

---

**REMU**  

_Sintassi_: `remu rd, rs1, rs2`  
_Descrizione_: Resto della divisione unsigned  
_Esempio_:

```assembly
remu x5, x1, x2
```

---
#### Tabella Riassuntiva – Estensione M

|Istruzione|Descrizione breve|
|---|---|
|MUL|Moltiplicazione (parte bassa)|
|MULH|Moltiplicazione (parte alta, signed)|
|MULHSU|Moltiplicazione (mixed signed/unsigned, parte alta)|
|MULHU|Moltiplicazione (unsigned, parte alta)|
|DIV|Divisione signed|
|DIVU|Divisione unsigned|
|REM|Resto signed|
|REMU|Resto unsigned|

---
### ESTENSIONE A

Questa estensione abilita operazioni atomiche per la sincronizzazione in ambienti multithread. Questa guida è per operazioni a 32 bit (RV32A), per sistemi a 64 bit (RV64A) esistono equivalenti con suffisso `.d` (per “doubleword”).

---

**LR.W** (Load-Reserved Word)  

_Sintassi_: `lr.w rd, (rs1)`  
_Descrizione_: Carica il valore da memoria marcandolo per un’operazione atomica  
_Esempio_:

```assembly
lr.w x5, (x1)
```

---

**SC.W** (Store-Conditional Word)  

_Sintassi_: `sc.w rd, rs2, (rs1)`  
_Descrizione_: Memorizza in memoria solo se la “riserva” è valida; `rd` viene impostato a 0 se riuscito  
_Esempio_:

```assembly
sc.w x5, x2, (x1)  # se riuscito, x5 = 0
```

---

**AMOSWAP.W**  

_Sintassi_: `amoswap.w rd, rs2, (rs1)`  
_Descrizione_: Scambia atomicamente il contenuto di memoria con `rs2`  
_Esempio_:

```assembly
amoswap.w x5, x2, (x1)
```

---

**AMOADD.W, AMOXOR.W, AMOAND.W, AMOOR.W**  

_Sintassi_: `amoadd.w rd, rs2, (rs1)`  
_Descrizione_: Eseguono rispettivamente somma, XOR, AND e OR atomico  
_Esempio_:

```assembly
amoadd.w x5, x2, (x1)  # Somma atomica
```

---

**AMOMIN.W, AMOMAX.W, AMOMINU.W, AMOMAXU.W**  

_Sintassi_: `amomin.w rd, rs2, (rs1)`  
_Descrizione_: Operazioni atomiche per ottenere il minimo/massimo (signed/unsigned)  
_Esempio_:

```assembly
amomin.w x5, x2, (x1)
```

---
#### Tabella Riassuntiva – Estensione A

|Istruzione|Descrizione breve|
|---|---|
|LR.W / LR.D|Carica riservato (word/double)|
|SC.W / SC.D|Store condizionale (word/double)|
|AMOSWAP.W / AMOSWAP.D|Scambio atomico|
|AMOADD, AMOXOR, AMOAND, AMOOR|Operazioni aritmetiche/logiche atomiche|
|AMOMIN, AMOMAX, AMOMINU, AMOMAXU|Operazioni min/max atomiche|

---
### ESTENSIONE F

Questa estensione introduce operazioni in virgola mobile a 32 bit. 

---
#### Operazioni di Caricamento/Salvataggio

**FLW**  

_Sintassi_: `flw fd, offset(rs1)`  
_Descrizione_: Carica un numero in virgola mobile a 32 bit  
_Esempio_:

```assembly
flw f5, 0(x1)
```

---

**FSW**  

_Sintassi_: `fsw fs, offset(rs1)`  
_Descrizione_: Salva un numero in virgola mobile a 32 bit in memoria  
_Esempio_:

```assembly
fsw f5, 0(x1)
```

---
#### **Operazioni Aritmetiche**

**FADD.S, FSUB.S, FMUL.S, FDIV.S**  

_Sintassi_: `fadd.s fd, fs1, fs2` (analoghe per le altre)  
_Descrizione_: Somma, sottrazione, moltiplicazione e divisione in precisione singola  
_Esempio_:

```assembly
fadd.s f5, f1, f2  # f5 = f1 + f2 (single precision)
```

---

**FSQRT.S**  

_Sintassi_: `fsqrt.s fd, fs`  
_Descrizione_: Calcola la radice quadrata  
_Esempio_:

```assembly
fsqrt.s f5, f1
```

---
#### Operazioni di Conversione e Comparazione

**FCVT.W.S, FCVT.S.W** 

_Descrizione_: Conversioni tra interi e floating-point

---

**FEQ.S, FLT.S, FLE.S**  

_Descrizione_: Comparazioni tra valori in virgola mobile

---

**FCLASS.S**  

_Descrizione_: Classifica il numero in virgola mobile (NaN, infinito, ecc.)

---
#### Tabella Riassuntiva – Estensione F

|Istruzione|Descrizione breve|
|---|---|
|FLW / FSW|Caricamento/Salvataggio di valori float|
|FADD.S, FSUB.S, FMUL.S, FDIV.S|Operazioni aritmetiche float (singola precisione)|
|FSQRT.S|Radice quadrata float|
|FCVT.*, FEQ.S, FLT.S, FLE.S, FCLASS.S|Conversioni e comparazioni float|

---
### ESTENSIONE D

Simile all’estensione F, ma per operazioni in doppia precisione (64 bit). 

---

**FLD / FSD**  

_Sintassi_: `fld fd, offset(rs1)` / `fsd fs, offset(rs1)`  
_Descrizione_: Carica/Salva un double dalla/in memoria  
_Esempio_:

```assembly
fld f5, 0(x1) fsd f5, 0(x1)
```

---

**FADD.D, FSUB.D, FMUL.D, FDIV.D, FSQRT.D**  

_Descrizione_: Operazioni aritmetiche per double precision  
_Esempio_:

```assembly
fadd.d f5, f1, f2  # f5 = f1 + f2 in double precision
```

---

Conversioni e comparazioni:  
**FCVT.S.D, FCVT.D.S, FCVT.W.D, FCVT.D.W, FCVT.WU.D, FCVT.D.WU, FEQ.D, FLT.D, FLE.D, FCLASS.D**

---
#### Tabella Riassuntiva – Estensione D

|Istruzione|Descrizione breve|
|---|---|
|FLD / FSD|Caricamento/Salvataggio double|
|FADD.D, FSUB.D, FMUL.D, FDIV.D, FSQRT.D|Operazioni aritmetiche double|
|Conversioni e Comparazioni|FCVT.*, FEQ.D, FLT.D, FLE.D, FCLASS.D|

---
### ESTENSIONE C

L’estensione **C** riduce la dimensione del codice traducendo le istruzioni in un formato a 16 bit. Esistono molte varianti; ecco alcune tra le più comuni: 

---

**C.ADDI**  

_Descrizione_: Versione compressa di `addi`  
_Esempio_:

```assembly
c.addi x1, 1  # equivalente ad addi
```

---

**C.ADDI4SPN**  

_Descrizione_: Aggiunge un immediato al registro stack pointer (per allocare spazio nello stack)  
_Esempio_:

```assembly
c.addi4spn x2, 8  # modifica lo stack pointer
```

---

**C.LW, C.LD**  

_Descrizione_: Caricamento compresso di word/doubleword

---

**C.SW, C.SD**  

_Descrizione_: Salvataggio compresso

---

**C.J** e **C.JAL**  

_Descrizione_: Salti compressi (incondizionati)

---

**C.BEQZ** e **C.BNEZ**  

_Descrizione_: Salti condizionati compressi (basati su zero)

---

**C.SLLI, C.LI, C.ADDI16SP, C.LUI**  

_Descrizione_: Istruzioni compresse per immediati e operazioni speciali

---

L’insieme completo delle istruzioni compresse è numeroso e le loro codifiche dipendono da specifici campi all’interno dell’istruzione a 16 bit. Per ogni istruzione esiste un’equivalenza (o un’interpretazione compressa) dell’istruzione standard.

---
#### Tabella Riassuntiva – Estensione C (alcuni esempi)

| Istruzione                      | Descrizione breve                                    |
| ------------------------------- | ---------------------------------------------------- |
| C.ADDI                          | Aggiunge un immediato (compressa)                    |
| C.ADDI4SPN                      | Aggiunge immediato allo stack pointer                |
| C.LW / C.LD                     | Caricamento compresso da memoria                     |
| C.SW / C.SD                     | Salvataggio compresso in memoria                     |
| C.J / C.JAL                     | Salti incondizionati compressi                       |
| C.BEQZ / C.BNEZ                 | Branch compressi in base al confronto con zero       |
| C.SLLI, C.LI, C.ADDI16SP, C.LUI | Operazioni immediata e speciali in formato compresso |

---