L’**endianess** riguarda l’ordine in cui i byte di un dato multi-byte (ad esempio, una parola di 32 bit) vengono memorizzati in memoria. Ci sono due convenzioni principali:

**Little Endian:** Il byte meno significativo (LSB, Least Significant Byte) viene memorizzato all’indirizzo di memoria più basso, mentre il byte più significativo (MSB, Most Significant Byte) viene memorizzato all’indirizzo più alto.

**Big Endian:** Il byte più significativo (MSB) viene memorizzato all’indirizzo di memoria più basso, mentre il byte meno significativo (LSB) viene memorizzato all’indirizzo più alto.

---

Poiché RISC-V è **Little Endian**, ciò significa concretamente che, per dati che occupano più di un byte, il byte meno significativo viene conservato per primo in memoria. Vediamo un esempio pratico.

---

**Esempio:**

Considera di avere un’istruzione di dichiarazione dati in assembly RISC-V:

```assembly
.data
value: .word 0x12345678
```

In memoria, questo valore viene memorizzato nel seguente ordine:

| Indirizzo    | Valore memorizzato (Byte) |
| ------------ | ------------------------- |
| `0x10010000` | 0x78 (LSB)                |
| `0x10010001` | 0x56                      |
| `0x10010002` | 0x34                      |
| `0x10010003` | 0x12 (MSB)                |

L’indirizzo più basso (`0x10010000`) contiene il **byte meno significativo** (0x78).
Gli indirizzi successivi memorizzano i byte in ordine ascendente, terminando con il **byte più significativo** (0x12).

---