Il **Program Counter** (**PC**) è un registro della [[CPU]] che contiene l'indirizzo della prossima istruzione da eseguire (essenziale per il controllo del flusso di un programma).

---
### FUNZIONAMENTO

**1.** All'inizio di un ciclo di [[Execution Steps#1. (IF) FETCH|fetch]], il PC indica l'indirizzo dell'istruzione corrente.

**2.** Dopo che l'istruzione è stata recuperata dalla memoria, il PC viene aggiornato per puntare all'istruzione successiva.

**3.** Se l'istruzione è un **salto (branch, jump, call, ecc.)**, il PC viene aggiornato con un nuovo indirizzo invece di avanzare in modo sequenziale.

---
### ESEMPIO IN RISC-V

Consideriamo il seguente codice assembly:

```assembly
addi x1, x0, 5   # x1 = 5
addi x2, x0, 10  # x2 = 10
beq x1, x2, label  # Se x1 == x2 salta a "label"
addi x3, x0, 20  # x3 = 20 (questa istruzione potrebbe essere saltata)
label:
```

- Se il **branch** non viene preso, il PC avanza normalmente di 4 byte (architettura a 32 bit --> allineamento a 4 byte).
- Se il branch viene preso, il PC viene aggiornato con l'indirizzo di **label**, alterando il flusso di esecuzione.

---
### CARATTERISTICHE

Il valore del PC dipende dall'architettura:

- In **RISC-V a 32 bit**, ogni istruzione è lunga 4 byte, quindi il PC avanza di **4** in un'esecuzione normale.
- In architetture con istruzioni variabili (es. x86), l'incremento del PC dipende dalla lunghezza dell'istruzione.

Il PC viene salvato in caso di **interrupt o chiamate di subroutine**, in registri speciali come `ra` (Return Address) in RISC-V.

---