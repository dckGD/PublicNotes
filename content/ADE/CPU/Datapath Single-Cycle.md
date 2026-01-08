In un **datapath RISC-V a singolo ciclo**, i componenti principali riflettono l'architettura **load/store** del RISC-V e supportano l’esecuzione delle istruzioni in modo semplice ed efficiente. 

---
### COMPONENTI DEL DATAPATH
#### Instruction Memory

Contiene il **programma** (cioè tutte le istruzioni RISC-V). Ogni ciclo, viene letta **l’istruzione corrente** usando l’indirizzo contenuto nel **Program Counter (PC)**.

**Ingressi:** 

`Address` (32 bit): È il valore del **Program Counter (PC)**, indica quale istruzione recuperare dalla memoria.

**Uscite:** 

`Instruction` (32 bit): L’istruzione a 32 bit letta dalla memoria all’indirizzo `PC` (va al blocco di decodifica).

---
#### Program Counter (PC)

Tiene traccia dell’indirizzo della prossima istruzione da eseguire.
Viene aggiornato a ogni ciclo (PC + 4 o salto/branch). 

---
#### Register File

[[General Registers in RISC-V|32 registri]] (`x0`–`x31`) da 32 bit ciascuno.
Ogni registro è **indirizzabile con 5 bit** (infatti 2⁵ = 32).
([[Instruction Formats|guarda il formato delle istruzioni]])  

**Ingressi**:

`rs1` (5 bit) → registro da leggere 1 
`rs2` (5 bit) → registro da leggere 2 
`WriteData` (32  bit) → valore da scrivere in `rd`

**Segnali di controllo:**

`RegWrite`:  ([[Execution Steps#5. (WB) WRITE BACK|controllo fase di write back]])

- **1** → abilita la scrittura nel registro `rd`
- **0** → disabilita la scrittura (registro rimane invariato)
- 
(Se `RegWrite = 1`, al **prossimo fronte di clock**, il contenuto di `WriteData` viene scritto nel registro `rd`).

**Uscite**:

`rd` (5 bit) → registro dove scrivere 
`ReadData1` (32 bit) → contenuto di `rs1`
`ReadData2` (32 bit) → contenuto di `rs2`

---
#### ALU

([[CPU Units#ALU (Arithmetic Logic Unit)|ALU]]) Esegue operazioni aritmetiche e logiche (es: somma, AND, OR, confronto) e calcola indirizzi (base + offset). L'operazione da eseguire viene determinata dal segnale di controllo **ALUControl**. 

**Ingressi**:

`Operand A` (32 bit) ← tipicamente da `ReadData1` (registro `rs1`)
`Operand B` (32 bit) ← da `ReadData2` (registro `rs2`) oppure da **Immediate** (in base al valore del segnale `ALUSrc`). ^41b6e9

**Segnali di controllo:**

`ALUControl` (4 bit) ← indica quale operazione eseguire (es. `0010` per add)

**Uscite**:

`ALUResult` (32 bit): il risultato dell’operazione
`Zero` (1 bit):

- Vale **1** se `ALUResult == 0`
- Serve **per il [[Instructions Set#Branch (Salti condizionati - Instruction formats e6ae1f Formato B )|branch]]** (`beq`, `bne`, ecc.) 
    ES: 
    Istruzione: `beq x1, x2, label`
    L’ALU esegue: `x1 - x2`
    Se `Zero == 1` → significa `x1 == x2` → il branch è preso

---
#### ALU Control

Determina quale operazione l’ALU deve eseguire, in base al tipo di istruzione.

l’**ALU Control** riceve dalla **Control Unit** un segnale chiamato `ALUOp`, che può essere codificato con **2 bit** (`ALUOp1` e `ALUOp0`) per distinguere i **tipi di istruzioni**.

Poi, in base a `ALUOp` e — **solo se serve** — ai campi `funct3` e `funct7` dell’istruzione, decide quale operazione l’ALU deve eseguire.

| `ALUOp` | Significato                               | Azione dell’ALU Control                                                           |
| ------- | ----------------------------------------- | --------------------------------------------------------------------------------- |
| `00`    | **lw**, **sw**                            | Forza l’operazione di **somma** (che calcola l'indirizzo in memoria)              |
| `01`    | **beq**                                   | Forza l’operazione di **sottrazione** (`x1 - x2` per vedere quindi se `x1 == x2`) |
| `10`    | **R-type** (`add`, `sub`, ecc.)           | Analizza `funct3` e `funct7` per decidere quale operazione eseguire               |
| `11`    | (eventuale uso per `I-type` o estensioni) | (opzionale: si può usare per `addi`, `ori`, ecc.)                                 |

>`ALUOp = 10` è l’unico caso in cui l’ALU Control deve **decodificare i campi dell’istruzione** (funct3 e funct7).

---
#### Sign Extension Unit/Immediate Generator

>_(blocco "Genera cost" nello schema sotto)_

Esegue due operazioni:

Estrae e segna l’immediato dall’istruzione (I-type, S-type, B-type…).
L’immediato è usato come operando nell’ALU o per i salti.

Estende un numero intero **relativo** rappresentato in **Complemento a 2 (CA2)** da un numero di bit minore (es. 12 o 16 bit) a **32 bit**, **preservando il segno**:

Se l’**MSB** dell’immediato è `0` → numero positivo  
→ si aggiungono **zeri** in testa
Se l’MSB dell'immediato è `1` → numero negativo  
→ si aggiungono **uni** in testa

**Ingressi:**

`Immediate`(es. 12 o 16 bit): valore immediato dell’istruzione, in complemento a 2

**Uscite:**

`ExtendedImmediate`(32 bit): versione a 32 bit dell’immediato, con estensione di segno

**Esempio:**

Immediato a 16 bit (IN): `1111 1111 1111 1000`  
→ MSB = `1` → estensione del segno (OUT): `1111 1111 1111 1111 1111 1111 1111 1000`  
(risultato a 32 bit, valore = –8)

---
#### Control Unit

Decodifica il tipo di istruzione (R, I, S, B, U, J) e genera i segnali di controllo. 

Ecco la **tabella dei segnali di controllo** generati dalla **Control Unit (CU)** per i principali tipi di istruzioni RISC-V (R-type, `lw`, `sw`, `beq`). 

| Istruzione | RegWrite | ALUSrc | MemToReg | MemRead | MemWrite | Branch | ALUOp1 | ALUOp0 |
| ---------- | -------- | ------ | -------- | ------- | -------- | ------ | ------ | ------ |
| **R-type** | 1        | 0      | 0        | 0       | 0        | 0      | 1      | 0      |
| **`lw`**   | 1        | 1      | 1        | 1       | 0        | 0      | 0      | 0      |
| **`sw`**   | 0        | 1      | X        | 0       | 1        | 0      | 0      | 0      |
| **`beq`**  | 0        | 0      | X        | 0       | 0        | 1      | 0      | 1      |
|            |          |        |          |         |          |        |        |        |

> **Legenda:**
> -`0`: Segnale disattivato.
> -`1`: Segnale attivato.
> -`X`: Don't care (non rilevante per l'istruzione).

- **ALUSrc**: Seleziona la seconda sorgente dell'ALU. `0` per `ReadData2` (registro), `1` per l'immediato esteso.
- **MemtoReg**: Seleziona il dato da scrivere nel registro. `0` per il risultato dell'ALU, `1` per il dato letto dalla memoria.
- **RegWrite**: Abilita la scrittura nel registro di destinazione (`rd`).
- **MemRead**: Abilita la lettura dalla memoria dati.
- **MemWrite**: Abilita la scrittura nella memoria dati.
- **Branch**: Indica se l'istruzione è un branch (`beq`).
- **ALUOp1 e ALUOp0**: Determinano l'operazione dell'ALU. Questi segnali vengono ulteriormente decodificati dall'ALU Control per selezionare l'operazione specifica.

---
#### Data Memory

Utilizzata per caricare (`lw`) o scrivere (`sw`) dati dalla/alla memoria.
Accesso controllato dai segnali `MemRead` e `MemWrite`.

**Ingressi:**

`Address`(32 bit): Indirizzo di memoria (calcolato dall’ALU)
`WriteData` (32 bit): Dato da scrivere nella RAM (viene da un registro, `rs2`)

**Segnali di controllo:**

`MemRead` (1 bit): Se `1`, abilita la **lettura** dalla memoria ([[Execution Steps#4. (MEM) MEMORY|controllo fase di memory]])
`MemWrite` (1 bit): Se `1`, abilita la **scrittura** nella memoria ([[Execution Steps#4. (MEM) MEMORY|controllo fase di memory]])

**Uscite:**

`ReadData` (32 bit): Dato letto dalla memoria (valido se `MemRead=1`)

---
#### Multiplexer (MUX)

Usati per selezionare tra due fonti alternative.
Esempi:

---
##### 1. MUX controllato da `ALUSrc`

Serve a scegliere il **secondo operando dell’ALU**

Segnale: **`ALUSrc`**

- Se `0` → si usa `ReadData2` (contenuto del registro `rs2`)
- Se `1` → si usa **l’immediato esteso**

**Esempio:**

`add` → usa `rs1` e `rs2` → `ALUSrc = 0`
`addi`, `lw`, `sw` → usano `rs1` + immediato → `ALUSrc = 1`

---
##### 2. MUX controllato da `MemtoReg`

Serve a scegliere **cosa scrivere nel registro `rd`**

Segnale: **`MemtoReg`**

- Se `0` → si scrive il **risultato dell’ALU**
- Se `1` → si scrive il **valore letto dalla memoria (`ReadData`)**

**Esempio:**
`add`, `sub`, `slt`, `addi`, ecc. → `MemtoReg = 0`
`lw` → `MemtoReg = 1`

---
##### 3. MUX controllato da `PCSrc`

Serve per decidere quale valore mandare al PC nel ciclo successivo

Segnale: **`PCSrc`**

- Se `0` → niente salto → `PC + 4`
- Se `1` → salto (`beq` vero : `Zero` = 1) → `PC + offset`

---
#### Adders

Un sommatore è usato per incrementare `PC` (tipicamente `PC + 4`).
Un altro può calcolare l’indirizzo del branch (`PC + immediate`).

---
##### 1. Adder per `PC + 4`

Calcola l'indirizzo della **prossima istruzione** (sequenziale)

**Ingressi:**

`PC` (valore corrente)
Costante `4`

**Uscita:**

`PC + 4`, che viene:

- mandato direttamente al **MUX per il nuovo PC**
- e/o usato anche per **salti incondizionati** (`jal`)

---
##### 2. Adder per `salti condizionati/incondizionati`

Calcola l’indirizzo di **destinazione del salto** (`PC + offset`)

**Ingressi:**

`PC` (valore corrente)
**Immediato esteso** (sign-extended + shiftato a sinistra di 1, ovvero moltiplicato x2)

**Uscita:**

`PC + offset`, usato come:

- **possibile nuovo valore del PC**
- collegato a un **MUX controllato da `PCSrc`**

---
#### Shift sinistro di 1 (×2)

Per i salti (come `beq`, `jal`, ecc.), l’immediato è **shiftato a sinistra di 1 bit**, cioè moltiplicato per 2. Questo avviene **prima di sommare l’offset al PC**.

>_Implicito nello schema sotto: si trova tra l'uscita di `Genera cost` e l'ingresso del secondo `adder`, in alto a destra._

---

### DATAPAH COMPLETO (SENZA IMPLEMENTAZIONI)

![[Pasted image 20250602145552.png]]

---
### SUDDIVISIONE DEL DATAPATH

![[Pasted image 20250616141454.png]]

Ogni parte del datapath è adibita ad una specifica [[Execution Steps|fase]].

---
### ESEMPI DI ESECUZIONE
#### Esecuzione di un'istruzione R

![[Pasted image 20250602145831.png]]

---
#### Esecuzione di `lw`

![[Pasted image 20250602150053.png]]

---
#### Esecuzione di `beq`

![[Screenshot 2025-06-02 150155.png]]

---
### ESEMPI DI IMPLEMENTAZIONI
#### Implementazione di `jal`

![[Pasted image 20250602145158.png]]

---