Un'**etichetta** è un **nome simbolico per un indirizzo** (scelto dallo sviluppatore) nel programma. Può indicare: un'istruzione (es. per i salti), una variabile o un dato in memoria.

**Sintassi**: `nome_etichetta:`

---

Le etichette sono collegate **automaticamente dall’assemblatore** all’**indirizzo corrente** del programma quando vengono definite.

**Esempio:

```assembly
valore: .word 42
```

**significa:**  

“A questo punto del segmento `.data`, all’indirizzo corrente, metti 42 e chiama questo indirizzo `valore`”.

**Esempio:**

```assembly
main:
    li a0, 1
```

**significa:**  

“Etichetta `main` = indirizzo di questa istruzione `li a0, 1`”.

---

L'assemblatore, quando trova un’etichetta:

1. Registra **l’indirizzo attuale** nel segmento (`.text`, `.data`, ecc.)
2. Salva una mappa simbolica tipo:

```text
main    → 0x00000000
valore  → 0x10010000
```

Poi, quando trovi istruzioni tipo `beq t0, t1, valore`, l’assemblatore sostituisce `valore` con il corretto **offset** in byte.

---

**Esempio con memoria:**

```assembly
.data
a:  .word 10
b:  .word 20

.text
main:
    la t0, a     # carica l’indirizzo di a
    lw t1, 0(t0) # t1 = contenuto di a → 10

    la t0, b
    lw t2, 0(t0) # t2 = contenuto di b → 20
```

**Associazione automatica:**

|Etichetta|Contenuto|Posizione (esempio)|
|---|---|---|
|`a:`|10|0x10010000|
|`b:`|20|0x10010004|

L’assemblatore assegna `a` all’indirizzo attuale, poi `b` alla posizione successiva (4 byte dopo, perché `.word`).

---