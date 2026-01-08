RISC-V segue un modello di **indirizzamento a byte**, ma per accedere a dati più grandi di un byte è necessario rispettare il vincolo di **allineamento**:

| Tipo di dato            | Allineamento | Indirizzi validi | Esempio                     |
| ----------------------- | ------------ | ---------------- | --------------------------- |
| **Byte** (8 bit)        | 1 byte       | tutti            | 0x1000, 0x1001, 0x1002, ... |
| **Halfword** (16 bit)   | 2 byte       | multipli di 2    | 0x1000, 0x1002, 0x1004, ... |
| **Word** (32 bit)       | 4 byte       | multipli di 4    | 0x1000, 0x1004, 0x1008, ... |
| **Doubleword** (64 bit) | 8 byte       | multipli di 8    | 0x1000, 0x1008, 0x1010, ... |

---

La RAM, infatti, è organizzata in un insieme di unità minime di memorizzazione, che possiamo chiamare "celle" o "locazioni di memoria". La dimensione della singola locazione di memoria è generalmente fissata a **1 byte** (8 bit) nella maggior parte delle architetture moderne. Tuttavia, la dimensione della [[Instruction Formats|parola]] (word size) varia in base all'[[ISA]] (Instruction Set Architecture). Ad esempio:

- **RISC-V a 32 bit:** parola di 32 bit (4 byte)
- **RISC-V a 64 bit:** parola di 64 bit (8 byte)

---

**Esempio:** 

una word viene caricata a partire dall'indirizzo 0x1000 (che, per essere corretta, deve essere un multiplo di 4), essa occupa:

0x1000 → primo byte
0x1001 → secondo byte
0x1002 → terzo byte
0x1003 → quarto byte

Quindi, la word **copre 4 indirizzi** (che sono 4 celle di memoria).

---

Le [[CPU]] moderne accedono alla memoria in unità multiple di byte (parole da 16, 32 o 64 bit). Se un dato è **allineato** (cioè memorizzato a un indirizzo multiplo della sua dimensione), il processore **può leggerlo in un singolo ciclo di memoria**.

Se invece il dato **non è allineato**, potrebbe essere necessario:

- Effettuare **due accessi alla memoria** per caricare la parte inferiore e superiore del dato.
- Combinare i dati con operazioni aggiuntive a livello di hardware.

Questa operazione **complica l'hardware e riduce le prestazioni**.

---

**Esempio di accesso allineato e non allineato**:

| Indirizzo           | 0x1000 | 0x1001 | 0x1002 | 0x1003 | 0x1004 | 0x1005 | 0x1006 | 0x1007 |
| ------------------- | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ |
| **Dati in memoria** | 0xFE   | 0xEF   | 0xNY   | 0xTO   | 0x11   | 0x22   | 0x33   | 0x44   |

(L'ordine dei byte è [[Endianess|Little Endian]])

Se faccio un `LW x2, 0(x1)`, dove `x1 = 0x1000`, carico direttamente `0xTONYEFFE` in un solo ciclo. 

Se invece faccio un `LW x2, 1(x1)`, dove `x1 = 0x1001`, dovrei leggere due blocchi separati (`0xNYEFFE` e `0x11`), poi combinare i dati

---

