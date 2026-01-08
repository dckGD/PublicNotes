Una syscall (system call) è un meccanismo che consente a un programma in modalità utente di richiedere servizi al sistema operativo o al simulatore (come RARS). Questi servizi possono riguardare operazioni di input/output, terminazione del programma, gestione della memoria, e altro. Le syscall permettono al codice utente di interagire con funzionalità protette o hardware, senza dover gestire direttamente i dettagli del sistema.

---
### UTILIZZO DEI REGISTRI E ECALL

In RISC-V (e nei relativi ambienti didattici come RARS) la convenzione per le syscall prevede l'uso di specifici [[General Registers in RISC-V|registri]]:

**a7:**  
Contiene il numero identificativo della syscall. Ad esempio, nel simulatore RARS, il valore 4 in a7 indica la syscall per stampare una stringa.

**a0, a1, a2, …:**  
Vengono utilizzati per passare i parametri o argomenti alla syscall. Ad esempio, per una syscall che stampa una stringa, **a0** contiene l'indirizzo della stringa.

**ecall:**  
È l'istruzione che viene eseguita per attivare la syscall. Quando viene eseguita, il sistema legge i registri (a7 e quelli argomentativi) e svolge l'azione richiesta.

---
### ESEMPIO COMPLETO IN RISC-V (RARS)

Supponiamo di voler stampare la stringa "Hello world!" utilizzando la syscall per la stampa delle stringhe.

```assembly
.data
string: .asciz "Hello world!"   # Stringa terminata da 0

.text
main:
    li   a7, 4                  # Numero della syscall: 4 (print string)
    la   a0, string             # Carica l'indirizzo della stringa in a0
    ecall                       # Esegue la syscall (stampa la stringa)
    
    # Uscita dal programma      # (syscall exit)
    li   a7, 10                 # Numero della syscall: 10 (exit)
    ecall                       # Termina il programma

```

La stringa viene definita nella sezione dati con la direttiva `.asciz`, che crea una stringa terminata da zero. In **main**:

- `li a7, 4`: Carica il numero 4 in a7, che nel simulatore RARS indica la syscall di stampa della stringa.
- `la a0, string`: Carica l'indirizzo della stringa "Hello world!" nel registro a0, che fornisce l'argomento alla syscall.
- `ecall`: L'istruzione che invoca il gestore di syscall, che nel nostro caso stampa la stringa.
- `li   a7, 10`: Viene eseguita una syscall di uscita usando il numero 10 in a7.

---
### SYSCALL COMUNI IN RISC-V

Queste sono alcune syscall comunemente usate:

| **Numero (a7)** | **Nome Syscall** | **Argomenti** (input/output)              | **Descrizione**                        |
| --------------- | ---------------- | ----------------------------------------- | -------------------------------------- |
| 1               | Print Integer    | a0 = intero da stampare                   | Stampa un numero intero                |
| 4               | Print String     | a0 = indirizzo della stringa (`.asciz`)   | Stampa una stringa                     |
| 5               | Read Integer     | (output) → a0 = intero letto              | Legge un intero da input               |
| 8               | Read String      | a0 = indirizzo buffer, a1 = lunghezza max | Legge una stringa (max `a1` caratteri) |
| 10              | Exit             | —                                         | Termina il programma                   |
| 11              | Print Character  | a0 = carattere ASCII (es. 'A' = 65)       | Stampa un carattere                    |
| 12              | Read Character   | (output) → a0 = carattere letto           | Legge un carattere da input            |

---