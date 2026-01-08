Una **direttiva** è un **comando per l’assemblatore** (**non un’istruzione che la CPU esegue**).
**Serve per:** organizzare il codice, riservare memoria, dichiarare dati, indicare l’ingresso del programma, importare simboli globali. Ecco le più importanti:

---
### `.data`

Serve per dichiarare la **sezione dati**, dove definisci variabili, costanti, stringhe ecc.

```assembly
.data
x:   .word 42           # x è un intero a 32 bit
s:   .asciiz "Ciao!"    # s è una stringa null-terminated
```

---
### `.text`

Indica l’inizio della **sezione di codice eseguibile** (le istruzioni del programma).

```assembly
.text
main:
    li a0, 1
```

---
### `.globl`

Serve per dichiarare un’etichetta come **globale**, cioè visibile da fuori (necessaria per `main`, quando si lavora con più file).

```assembly
.globl main
.text
main:
    li a0, 42
```

Se non si mette `.globl main`, molti ambienti non trovano il punto d’ingresso del programma.

---
### `.word`

Riserva 4 byte (32 bit) in memoria e li inizializza.

```assembly
.data
x: .word 5      # intero a 32 bit
```

Si può anche usare per più valori:

```assembly
valori: .word 1, 2, 3, 4
```

---
### `.asciiz`

Crea una **stringa terminata da `\0` (null character)**, compatibile con le syscall tipo stampa stringa.

```assembly
msg: .asciiz "Ciao mondo!"
```

---
### `.byte`, `.half`, `.double`

Riservano e inizializzano dati di altri formati rispetto a `.word`:

```assembly
x: .byte 10         # 1 byte
y: .half 1000       # 2 byte (16 bit)
z: .double 12345678 # 8 byte (64 bit)
```

---