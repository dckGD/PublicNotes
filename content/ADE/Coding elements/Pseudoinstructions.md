Le **pseudoistruzioni** in Assembly RISC-V sono **istruzioni "di comodo"** che non esistono realmente nell'insieme di istruzioni base ([[ISA]]), ma che vengono tradotte dal **compilatore o dall'assembler** in una o più **istruzioni reali** (istruzioni **"reali" o "primitive"**) supportate dalla [[CPU]]. In pratica, servono per **semplificare la scrittura del codice assembly**, rendendolo più leggibile e simile ad altri linguaggi assembly.

---

**Esempi comuni di pseudoistruzioni in RISC-V:**

### ISTRUZIONE `li`

**Sintassi:** `li rd, imm`

**Descrizione:**  Carica un valore immediato (imm) nel registro `rd`.  (load immediate)

**Traduzione:**  Viene tradotta in una combinazione di istruzioni reali, tipicamente usando `lui` e `addi`.  

**Esempio:**

```assembly
li t0, 42    # Carica 42 nel registro t0
```

---
### ISTRUZIONE `la`

**Sintassi:** `la rd, label`

**Descrizione:** Carica l'indirizzo (address) dell'etichetta (label) specificata nel registro `rd`. (load address) 

**Traduzione:** Viene tradotta in una combinazione di istruzioni quali `lui` e `addi` per comporre l'indirizzo completo dell'etichetta.

**Esempio:**

```assembly
la t0, my_data 
# Carica l'indirizzo della variabile/etichetta my_data in t0
```

---
### ISTRUZIONE `move`

_(spesso abbreviato in **mv**)_
**Sintassi:** `move rd, rs`

**Descrizione:** Copia il contenuto del registro `rs` nel registro `rd`.  

**Traduzione:**  Viene tradotta nell'istruzione reale: `add rd, rs, x0`, dove `x0` è il registro zero (contenente sempre 0).

**Esempio:**

```assembly
move t0, t1    # Copia il contenuto di t1 in t0
```

---
### ISTRUZIONE `neg`

**Sintassi:** `neg rd, rs`

**Descrizione:** Calcola il negativo (l'opposto) del contenuto di `rs` e lo mette in `rd`. In altre parole, esegue `rd = -rs`.

**Traduzione:** Viene tradotta nell'istruzione reale: `sub rd, x0, rs` (viene sottratto il contenuto di `rs` da 0).

**Esempio:**

```assembly
neg t0, t1    # Calcola -t1 e lo memorizza in t0
```    

---
### ISTRUZIONE `not`

**Sintassi:** `not rd, rs`

**Descrizione:** Esegue l'operazione bitwise NOT sul contenuto di `rs` e memorizza il risultato in `rd`. Invertendo ogni bit di `rs` (0 diventa 1 e viceversa).

**Traduzione:** Viene tradotta utilizzando l'istruzione `xori` con -1, cioè: `xori rd, rs, -1`

**Esempio:**
```assembly
not t0, t1    
# Calcola il complemento bit a bit di t1 e lo memorizza in t0
````

---
### ISTRUZIONE `nop`

**Sintassi:** `nop`

**Descrizione:** Esegue "no operation" (nessuna operazione), utile come placeholder o per sincronizzare l'esecuzione in determinati casi. 

**Traduzione:** Viene tradotta con un'istruzione che non altera alcun registro, tipicamente: `add x0, x0, x0`

**Esempio:**

```assembly
nop    # Non esegue alcuna operazione
```

---
### ISTRUZIONE `ret`

**Sintassi:** `ret`

**Descrizione:** Ritorna dall'attivazione di una subroutine. Salta all'indirizzo memorizzato nel registro di ritorno `ra`.

**Traduzione:** Viene tradotta nell'istruzione: `jalr x0, 0(ra)`.

**Esempio:**

```assembly
ret    # Ritorna dalla subroutine corrente (equivale a jr ra)`
```

---
### ISTRUZIONE `call`

**Sintassi:** `call label`

**Descrizione:** Effettua una chiamata a una subroutine individuata da `label`. Salva l'indirizzo di ritorno nel registro `ra` e salta all'etichetta.

**Traduzione:** Viene tradotta come: `jal ra, label`

**Esempio:**

```assembly
call my_function    
# Salta a my_function salvando l'indirizzo di ritorno in ra
```

---
### ISTRUZIONI `j`/`jr`

**Sintassi:**
`j label` 
`jr rs` 

**Descrizione:**
**j:** Salta incondizionatamente all'etichetta `label`, non specifica l'indirizzo di ritorno.
**jr:** Salta all'indirizzo contenuto nel registro `rs`.

**Traduzione:**
**j label** viene tradotto in: `jal x0, label`
**jr rs** viene tradotto in: `jalr x0, 0(rs)`

**Esempio:

```assembly
j funzione     # salta a funzione ignorando l'indirizzo di ritorno

...

funzione:
  ...
  jr ra        # ritorna all'indirizzo del chiamante
```

---
### ISTRUZIONI `beqz` / `bnez`

**Sintassi:** 

`beqz rs, label`
`bnez rs, label`

**Descrizione:** 

**beqz:** Salta a `label` se il registro `rs` è uguale a zero.
**bnez:** Salta a `label` se il registro `rs` è diverso da zero.

**Traduzione:**

**beqz rs, label** viene tradotto in: `beq rs, x0, label`
**bnez rs, label** viene tradotto in: `bne rs, x0, label`

**Esempio:**

```assembly
beqz t0, zero_case   # Se t0 è uguale a 0, salta a zero_case 
bnez t1, non_zero    # Se t1 è diverso da 0, salta a non_zero
```

---