Un **buffer** in Java è una **porzione di memoria temporanea** usata per immagazzinare dati in transito tra due componenti, tipicamente tra un programma e una sorgente o destinazione di dati (come un file, una rete, o un dispositivo di I/O).

**Scopo principale:** migliorare l’efficienza delle operazioni di input/output. Ad esempio, leggere o scrivere un carattere alla volta su disco è lento, ma usare un buffer permette di accumulare più dati prima di eseguire l’operazione fisica di I/O, riducendo il numero di chiamate e velocizzando il processo.

**Come funziona:** I dati vengono prima copiati nel buffer (memoria temporanea). Quando il buffer è pieno o viene forzata la scrittura (`flush()`), i dati vengono trasferiti alla destinazione finale (file, console, rete, ecc.).

---