I valori immediati nei formati B, J e U vengono codificati nelle istruzioni in modi particolari:

---
### FORMATO B (BRANCH)

**Caratteristiche:** 

**Immediato "sparso":** L’immediato è codificato su 12 bit, ma i bit non sono contigui all’interno dell’istruzione.

**Shift implicito:** Poiché gli indirizzi di branch sono allineati (tipicamente a 2 byte o 4 byte), il bit meno significativo (`imm[0]`) è sempre = 0 (numeri binari multipli di 2 o di 4) quindi non viene codificato. L'immediato viene quindi shiftato implicitamente a destra di una posizione con l'eliminazione di`imm[0]`.

**Ricostruzione:** Il processore, durante la decodifica, sa che il bit meno significativo è sempre `0`, quindi lo reinserisce automaticamente. Il valore immediato si ricostruisce assemblando i bit in questo ordine (l'immediato fuori dall'istruzione ha 12 + 1 bit):

```css
{imm[12], imm[11], imm[10:5], imm[4:1], 0} 
/* Da notare che l'immediato fuori dalla codifica è a 13 bit e non 12
/* Inoltre notiamo che imm[11] viene rimesso al suo posto
```

---

**Esempio:**  

Considera l’istruzione:

```assembly
BEQ x5, x6, 16
```

**Offset richiesto:** 16 byte.
**Shift implicito:** 16 ÷ 2 = 8. (immediato codificato = 8)
**8 in binario (12 bit):**

```yaml
# immediato iniziale: (13 bit)
0000000010000
# tolgo il bit meno significativo (shift implicito) (12 bit)
000000001000  
# immediato codificato: (12 bit sparsi)
0 rs2 rs1 funct3 000000 1000 0 opcode
```

**Distribuzione nella codifica:**

`imm[12]` = 0 
`imm[10:5]` = 000000
`imm[4:1]` = 1000
`imm[11]` = 0

Bit `imm[0]` implicito = 0  (non codificato)

Alla ricostruzione, il processore ricava l’offset 16 byte (lungo 12 bit + 1) ricomponendo i bit nel giusto ordine e aggiungendo il bit meno significativo (0).

---
### FORMATO J (JUMP)

**Caratteristiche:** 

**Immediato "sparso":** L’immediato per le istruzioni di salto (come JAL) è codificato su 20 bit con una disposizione non lineare.

**Shift implicito:** Poiché gli indirizzi di jump sono allineati, il bit meno significativo (`imm[0]`) è sempre = 0 (numeri binari multipli di 2 o di 4) quindi non viene codificato. L'immediato viene quindi shiftato implicitamente a destra di una posizione con l'eliminazione di`imm[0]`.

**Ricostruzione:** Il processore, durante la decodifica, sa che il bit meno significativo è sempre `0`, quindi lo reinserisce automaticamente. Il valore immediato si ricostruisce assemblando i bit in questo ordine (l'immediato fuori dall'istruzione ha 20 + 1 bit):

```css
{imm[20], imm[19:12], imm[11], imm[10:1], 0}
/* Da notare che l'immediato fuori dalla codifica è a 21 bit e non 20
/* Ogni bit viene rimesso al suo posto
```

---

**Esempio:**  

Considera l’istruzione:

```assembly
JAL x1, 1024
```

**Offset richiesto:** 1024 byte.
**Shift implicito:** 1024 ÷ 2 = 512.
**512 in binario (20 bit):**  

```yaml
# immediato iniziale: (21 bit)
0000000010000000000
# tolgo il bit meno significativo (shift implicito) (20 bit)
000000001000000000
# immediato codificato: (20 bit sparsi)
0 1000000000 0 0000000 rd opcode
```

**Distribuzione nella codifica:**

`imm[20]` = 0 
`imm[10:1]` = 1000000000
`imm[11]` = 0
`imm[19:2]` = 0000000

Bit `imm[0]` implicito = 0  (non codificato)

Alla ricostruzione, il processore ricava l’offset 1024 byte (lungo 20 bit + 1) ricomponendo i bit nel giusto ordine e aggiungendo il bit meno significativo (0).

---
### FORMATO U (UPPER IMMEDIATE)

**Caratteristiche:** 

**Immediato a 20 bit "allineato":** In questo formato (usato in istruzioni come LUI o AUIPC) l’immediato viene memorizzato nei bit dal 31° al 12° dell’istruzione.

**Shift a sinistra di 12 bit:** Durante l’esecuzione, il valore memorizzato viene shiftato a sinistra di 12 bit (moltiplicato per 4096), posizionandosi così nei bit più significativi e riempiendo con zeri quelli meno significativi (20 + 12 = 32 bit).
 
**Utilizzo:** Questo consente di rappresentare numeri di grande portata (ad esempio, la parte alta di un indirizzo).

---

**Esempio:**  

Considera l’istruzione:

```assembly
LUI x5, 1048576
```

**Valore finale desiderato:** 1048576.

**Immediato codificato:** 

$$
imm= \frac{1048576}{4096} =256
$$

**256 in binario (20 bit):**  

Il valore 256 in binario è `100000000₂`. Espresso su 20 bit (aggiungendo zeri a sinistra):

```yaml
00000000000100000000 
```

**Codifica nell’istruzione:**  

```yaml
imm[31:12]           # imm[11:0] non codificato
00000000000100000000 # + 000000000000 per fare 1048576
```

Al momento dell’esecuzione, il processore shift a sinistra di 12 bit l’immediato, ottenendo: 

$$
256×4096=1048576
$$

---

