Un array è una sequenza di elementi dello stesso tipo, posizionati in celle di memoria contigue.

---
### DICHIARAZIONE E MEMORIZZAZIONE

Gli array vengono dichiarati nella **sezione dati** (tipicamente `.data`), e quindi memorizzati in [[Virtual Memory|memoria]], mentre i registri vengono usati per:

- Tenere l'indirizzo di base dell'array.
- Calcolare l'indirizzo di un elemento specifico.
- Caricare e salvare i dati (con le istruzioni `lw`, `sw`, ecc.).

---
#### Esempio di dichiarazione di un array

Ad esempio, in RISC-V per dichiarare un array di 5 interi (5 word):

```assembly
.data
array: .word 10, 20, 30, 40, 50   # 5 elementi, ognuno di 4 byte (32 bit)
```

- **Numero di elementi:** 5 (vettore lungo 5 word).
- **Spazio occupato:** 5 elementi × 4 byte = 20 byte.

---
#### Esempio di memorizzazione fisica

Considerando l’array dichiarato sopra:

| Indice     | Valore | Indirizzo  | Dettaglio                       |
| ---------- | ------ | ---------- | ------------------------------- |
| `array[0]` | 10     | 0x10010000 | byte da 0x10010000 a 0x10010003 |
| `array[1]` | 20     | 0x10010004 | byte da 0x10010004 a 0x10010007 |
| `array[2]` | 30     | 0x10010008 | byte da 0x10010008 a 0x1001000B |
| `array[3]` | 40     | 0x1001000C | byte da 0x1001000C a 0x1001000F |
| `array[4]` | 50     | 0x10010010 | byte da 0x10010010 a 0x10010013 |

Da notare che gli elementi dell'array sono memorizzati in in ordine (da 0 a 4). Invece, ogni singolo elemento (word), è memorizzato in modo [[Endianess|Little Endian]] in RISC-V. 

**Ad esempio:**  `array[0]`

| Indirizzo  | Valore |
| ---------- | ------ |
| 0x10010000 | 0x0A   |
| 0x10010001 | 0x00   |
| 0x10010002 | 0x00   |
| 0x10010003 | 0x00   |

L'elemento `array[0]` = 10 = (`0x0000000A`), ha il LSB (`0x0A`) all'indirizzo 0x10010000.

---
### ACCESSO AGLI ELEMENTI

Per accedere logicamente a `array[i]` bisogna:

1. **Prendere l'indirizzo base** dell'array.
2. **Calcolare l'offset:** l'indice moltiplicato per la dimensione dell’elemento. Se l'elemento è una word (4 byte) allora: i x 4.
3. **Somma tra base e offset** per ottenere l'indirizzo esatto dell’elemento.

**Esempio:

Supponiamo di voler leggere `array[3]`:

```assembly
la   t0, array     # t0 = indirizzo base dell'array (es. 0x10010000)
li   t1, 3         # t1 = indice che vogliamo leggere
slli t1, t1, 2     # moltiplica l'indice per 4 (3 * 4 = 12);
add  t2, t0, t1    # t2 = indirizzo dell'elemento array[3]
                     (0x10010000 + 12 = 0x1001000C)
lw   t3, 0(t2)     # t3 contiene il valore di array[3] (40)
```

---
### MODIFICA DEGLI ELEMENTI

Per modificare, ad esempio, l’elemento `array[2]`:

```assembly
la   t0, array      # t0 = indirizzo base
li   t1, 2          # t1 = indice dell'elemento
slli t1, t1, 2      # t1 = offset = 2 * 4 = 8
add  t2, t0, t1     # t2 = indirizzo di array[2]
lw   t3, 0(t2)      # t3 = valore corrente di array[2]
addi t3, t3, 1      # incremento il valore (es. t3 = t3 + 1)
sw   t3, 0(t2)      # salvataggio del nuovo valore in array[2]
```

---