Le istruzioni in RISC-V hanno una lunghezza fissa di **32 bit** (nella versione base), con alcune estensioni che supportano istruzioni a 16, 48 e 64 bit (Compressed e altre varianti). 

---

Le istruzioni RISC-V a 32 bit hanno tutte la stessa lunghezza ma si dividono in diversi formati, ciascuno con una specifica organizzazione dei bit. I formati principali sono:

### 1. FORMATO R (REGISTER-REGISTER)

Questo formato è utilizzato per le istruzioni che operano su registri, come addizione e sottrazione. (nessun valore immediato) 

---
#### Struttura del formato R:

| Campo  | Bit | Funzione                             |
| ------ | --- | ------------------------------------ |
| funct7 | 7   | Specifica ulteriormente l'operazione |
| rs2    | 5   | Secondo registro sorgente            |
| rs1    | 5   | Primo registro sorgente              |
| funct3 | 3   | Specifica l'operazione               |
| rd     | 5   | Registro di destinazione             |
| opcode | 7   | Tipo di istruzione (Register)        |

---
#### Esempio:

L'istruzione `ADD x5, x6, x7` somma il valore di `x6` e `x7` e salva il risultato in `x5`:

```assembly
ADD x5, x6, x7 
```

L'istruzione in binario:

```r
+--------------------------------------------------------+
|   '/'   | 'x7'  | 'x6'  |  'ADD'   |  'x5'  |   'R'    |
+--------------------------------------------------------+
| 0000000 | 00111 | 00110 |   000    | 00010  | 0110011  | # tot: 32 bit
+--------------------------------------------------------+
|  funct7 |  rs2  |  rs1  |  funct3  |   rd   |  opcode  |
+--------------------------------------------------------+
```

---
### 2. FORMATO I (IMMEDIATE-REGISTER)

Questo formato è utilizzato per le istruzioni che coinvolgono un registro e un valore immediato (constante), come le operazioni di somma con un valore immediato, carico (load) o confronto. (valore immediato a 12 bit "uniti") 

---
#### Struttura del formato I:

| Campo     | Bit | Funzione                       |
| --------- | --- | ------------------------------ |
| imm[11:0] | 12  | Valore immediato (costante)    |
| rs1       | 5   | Primo registro sorgente        |
| funct3    | 3   | Specifica l'operazione         |
| rd        | 5   | Registro di destinazione       |
| opcode    | 7   | Tipo di istruzione (Immediate) |

---
#### Esempio:

L'istruzione `ADDI x5, x6, 10` somma il valore di `x6` e l'immediato 10, e salva il risultato in `x5`:

```assembly
ADDI x5, x6, 10
```

L'istruzione in binario:

```r
+--------------------------------------------------------+
|       '10'       | 'x6'  | 'ADD'  |  'x5'  |    'I'    |
+--------------------------------------------------------+
|   000000001010   | 00110 |  000   |  00101 |  0010011  |
+--------------------------------------------------------+
|    imm[11:0]     |  rs1  | funct3 |   rd   |  opcode   |
+--------------------------------------------------------+
```

---
### 3. FORMATO S (STORE)

Il formato S è utilizzato per le istruzioni che eseguono operazioni di store (salvataggio) su memoria. In queste istruzioni, un valore proveniente da un registro viene memorizzato in una posizione di memoria calcolata come somma di un registro e un valore immediato. (valore immediato a 12 bit "sparsi") 

---
#### Struttura del formato S:

| Campo     | Bit | Funzione                                        |
| --------- | --- | ----------------------------------------------- |
| imm[11:5] | 7   | Parte superiore del valore immediato            |
| rs2       | 5   | Secondo registro sorgente (dato da memorizzare) |
| rs1       | 5   | Primo registro sorgente (indirizzo di memoria)  |
| funct3    | 3   | Tipo di operazione (store)                      |
| imm[4:0]  | 5   | Parte inferiore del valore immediato            |
| opcode    | 7   | Tipo di istruzione (Store)                      |

---
#### Esempio:

L'istruzione `SW x5, 10(x6)` memorizza il contenuto del registro `x5` nella memoria all'indirizzo calcolato come somma del valore del registro `x6` e dell'immediato 10:

```assembly
SW x5, 10(x6)
```

L'istruzione in binario:

```r
+-------------------------------------------------------------+
|   '10'    |  'x5'  | 'x6'  |  'SW'  |   '10'   |    'S'     |
+-------------------------------------------------------------+
|  0000000  | 00101  | 00110 |  010   |  01010   |  0100011   |
+-------------------------------------------------------------+
| imm[11:5] |  rs2   |  rs1  | funct3 | imm[4:0] |   opcode   |
+-------------------------------------------------------------+
```

---
### 4. FORMATO B (BRANCH)

Il formato B è utilizzato per le istruzioni di **salto condizionato**, in cui l'esecuzione dipende dal risultato di un confronto tra due registri. (valore immediato a 12 bit "sparsi", [[B, J, U Formats Shifts#FORMATO B (BRANCH)|shift implicito]]) 

---
#### Struttura del formato B:

| Campo     | Bit | Funzione                                  |
| --------- | --- | ----------------------------------------- |
| imm[12]   | 1   | Bit di segno del valore immediato         |
| rs2       | 5   | Secondo registro sorgente (per confronto) |
| rs1       | 5   | Primo registro sorgente (per confronto)   |
| funct3    | 3   | Tipo di operazione (salto condizionato)   |
| imm[10:5] | 6   | Parte intermedia del valore immediato     |
| imm[4:1]  | 4   | Parte inferiore del valore immediato      |
| imm[11]   | 1   | Bit del valore immediato                  |
| opcode    | 7   | Tipo di istruzione (Branch)               |

---
#### Esempio:

L'istruzione `BEQ x5, x6, 16` esegue un salto di 16 byte se i registri `x5` e `x6` sono uguali.

```assembly
BEQ x5, x6, 16
```

L'istruzione in binario:

```r
+------------------------------------------------------------------------+
|  '16'   |'x5' |'x6' | 'BEQ'  |   '16'    |   '16'   |   '16'  |  'B'   |
+------------------------------------------------------------------------+
|    0    |00101|00110|  000   |   00001   |   0000   |    0    | 1100011|
+------------------------------------------------------------------------+
| imm[12] | rs2 | rs1 | funct3 | imm[10:5] | imm[4:1] | imm[11] | opcode |
+------------------------------------------------------------------------+
```

---
### 5. FORMATO U (UPPER IMMEDIATE)

Il formato U è utilizzato per le istruzioni che caricano un valore immediato a 20 bit nella parte superiore di un registro, come nelle istruzioni di "lavoro" con indirizzi di memoria a 32 bit o per impostare valori di registri con costanti elevate. (valore immediato a 20 bit "allineati" [[B, J, U Formats Shifts#FORMATO U (UPPER IMMEDIATE)|shift implicito]]) 

---
#### Struttura del formato U:

| Campo      | Bit | Funzione                             |
| ---------- | --- | ------------------------------------ |
| imm[31:12] | 20  | Parte superiore del valore immediato |
| rd         | 5   | Registro di destinazione             |
| opcode     | 7   | Tipo di istruzione (LUI)             |

---
#### Esempio:

L'istruzione `LUI x5, 1048576` carica il valore immediato 1048576 nel registro `x5`:

```assembly
LUI x5, 1048576
```

L'istruzione in binario:

```r
+---------------------------------------------+
|       '1048576'        |  'x5'  |   'LUI'   |     
+---------------------------------------------+
|  10000000000000000000  | 00101  |  0110111  |
+---------------------------------------------+
|       imm[31:12]       |   rd   |  opcode   |
+---------------------------------------------+
```

---
### 6. FORMATO J (JUMP)

Il formato **J** è utilizzato per le istruzioni di salto assoluto, come l'istruzione **JAL** (Jump and Link), che salta a un indirizzo calcolato come un offset relativo all'istruzione corrente e memorizza il ritorno nel registro **ra** (x1). (valore immediato a 20 bit "sparsi", [[B, J, U Formats Shifts#FORMATO J (JUMP)|shift implicito]])

---
#### Struttura del formato J:

| Campo      | Bit | Funzione                             |
| ---------- | --- | ------------------------------------ |
| imm[20]    | 1   | Bit più significativo dell'immediato |
| imm[10:1]  | 10  | Parte inferiore dell'immediato       |
| imm[11]    | 1   | Bit centrale dell'immediato          |
| imm[19:12] | 8   | Parte centrale dell'immediato        |
| rd         | 5   | Registro di destinazione (x1, ra)    |
| opcode     | 7   | Tipo di istruzione (Jump)            |

---
#### Esempio:

L'istruzione `JAL x1, 1024` salta all'indirizzo calcolato come somma dell'istruzione corrente e dell'immediato 1024 (00000000010000000000 in binario), e salva l'indirizzo di ritorno in **x1** (registro **ra**).

```assembly
JAL x1, 1024
```

L'istruzione in binario:

```r
+------------------------------------------------------------------+
|                   '1024'                     | 'x1'   |  'JAL'   | 
+------------------------------------------------------------------+
|    0    | 0000000000  |    1    |  00000000  | 00001  | 1101111  |
+------------------------------------------------------------------+
| imm[20] |  imm[10:1]  | imm[11] | imm[19:12] |   rd   |  opcode  |
+------------------------------------------------------------------+
```

---