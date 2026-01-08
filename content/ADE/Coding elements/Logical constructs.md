In RISC-V **non esistono costrutti ad alto livello** come `if`, `for`, ecc. — si usano **[[Instructions Set#Branch (Salti condizionati - Instruction Formats 4. FORMATO B (BRANCH) Formato B )|salti condizionati]] (`beq`, `bne`, `blt`, `bge`, ecc.)** e **[[Labels|etichette]] (`label:`)** per simulare la logica dei linguaggi ad alto livello:

---
### `if (condizione) then { ... } else { ... }`

```r
branch Else 
# codice da eseguire se la condizione è vera
j EndIf
Else:
# codice da eseguire se la condizione è falsa
Endif:
# codice seguente
```

**Esempio:

Codice in C:

```c
int x = 3
int y = 4;

if (x >= y) {
	a0 = 1;
}
else {
	a0 = 0;
}
```

Codice in assembly:

```assembly
li t0, 3        
li t1, 4        

blt t0, t1, Else 
li a0, 1
j EndIf

Else:
li a0, 0

EndIf:
```

N.B. la condizione è al contrario (se x < y allora salta a Else)

---
### `while (condizione) { ... }`

```r
LoopStart:
branch LoopEnd
# codice nel while
j LoopStart
LoopEnd:
# codice seguente
```

**Esempio:

Codice in C:

```c
int i = 0;

while (i < 5) {
    i++;
}
```

Codice in assembly:

```assembly
li t0, 0            
li t1, 5

LoopStart:
bge t0, t1, LoopEnd 
addi t0, t0, 1      
j LoopStart

LoopEnd:
```

N.B. la condizione è al contrario (se i >= 5 y allora salta a LoopEnd)

---
### `do { ... } while (condizione)`

```r
LoopStart:
# codice nel while
branch LoopStart
LoopEnd:
# codice seguente
```

**Esempio:

Codice in C:

```c
int i = 0;

do {
    i++;
} while (i < 5);
```

Codice in Assembly:

```assembly
li t0, 0
li t1, 5

LoopStart:
addi t0, t0, 1       
blt t0, t1, LoopStart

LoopEnd:
```

---
### `for (init; cond; update) { ... }`

```r
LoopStart:
branch LoopEnd       
# codice nel for
j LoopStart
LoopEnd:
# codice seguente
```

**Esempio:

Codice in C:

```c
for (int i = 0; i < 5; i++) {
    a0 = i + 10;
}
```

Codice in Assembly:

```assembly
li t0, 0
li t1, 5

LoopStart:
bge t0, t1, LoopEnd
addi a0, t0, 10
addi t0, t0, 1
j LoopStart

LoopEnd:
```

---
### `switch (x) { case ... }`

```r
# confronti multipli
beq x, val0, Case0
beq x, val1, Case1

j Default

Case0:
# codice del caso 0
j SwitchEnd

Case1:
# codice del caso 1
j SwitchEnd

Default:
# codice in caso tutti i casi sono FALSE

SwitchEnd:
# codice seguente
```

**Esempio:

Codice in C:

```c
int x = 2;

switch (x) {
    case 0: a0 = 100; break;
    case 1: a0 = 200; break;
    case 2: a0 = 300; break;
    default: a0 = -1;
}
```

Codice in Assembly:

```assembly
li t0, 2

li t1, 0
beq t0, t1, Case0

li t1, 1
beq t0, t1 Case1

li t1, 2
beq t0, t1, Case2

j Default

Case0:
li a0, 100
j SwitchEnd

Case1:
li a0, 200
j SwitchEnd

Case2:
li a0, 300
j SwitchEnd

Default:
li a0, -1

SwitchEnd:
```

N.B. `beq` non funziona con valori immediati, quindi ogni volta va caricato un valore su `t1` per poter verificare l'uguaglianza con il valore salvato in `t0`

---