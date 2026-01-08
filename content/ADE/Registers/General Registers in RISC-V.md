RISC-V utilizza **32 registri generali** identificati dai numeri **x0** a **x31**. Ogni registro è largo **32 bit** (o 64 bit su architetture a 64 bit). Questi registri sono utilizzati per operazioni di calcolo, archiviazione di dati temporanei, passaggio di parametri e risultato delle funzioni.

---

| **Registro (x0 - x31)** | **Gruppo di appartenenza**     | **Nome del registro** | **Funzione**                                                                                     |
| ----------------------- | ------------------------------ | --------------------- | ------------------------------------------------------------------------------------------------ |
| `x0`                    | Nessuno                        | `zero`                | È utilizzato per rappresentare un <br>valore costante di zero, non può<br>essere modifictao      |
| `x1`                    | Return Address (Link Register) | `ra`                  | Memorizza l'indirizzo di ritorno nelle chiamate di funzione.                                     |
| `x2`                    | Stack Pointer                  | `sp`                  | Puntatore allo stack.                                                                            |
| `x3`                    | Global Pointer                 | `gp`                  | Puntatore alla memoria globale.                                                                  |
| `x4`                    | Thread Pointer                 | `tp`                  | Puntatore al thread corrente (in <br>sistemi multitasking).                                      |
| `x5 - x7`<br>           | Temporary Registers            | `t0 - t2`             | Usati per operazioni temporanee e calcoli.                                                       |
| `x8`                    | Saved Register / Frame Pointer | `s0/fp`               | Utilizzato per il salvataggio dello <br>stato e per il frame pointer.                            |
| `x9`                    | Saved Register                 | `s1`                  | Utilizzato per il salvataggio dello <br>stato.                                                   |
| `x10 - x17`             | Argument <br>Registers         | `a0 - a7`             | Passano i parametri alle funzioni e <br>alle syscall.                                            |
| `x18 - x27`             | Saved Registers                | `s2 - s11`            | Memorizzano variabili che devono essere preservate tra le chiamate di funzione. (guarda la nota) |
| `x28 - x31`             | Temporary Registers            | `t3 - t6`             | Usati per operazioni temporanee, <br>senza bisogno di essere preservati <br>tra le chiamate.     |


> [!NOTE] Overlap
> Quando il numero di parametri da passare a una funzione supera 8, gli indirizzi da x18 a x25 possono diventare anch'essi **argument registers** (a8 - a15). In questo caso, per evitare sovrascritture e perdite, i valori memorizzati nei **saved registers** (s2 - s9) vengono **salvati nello stack** prima della chiamata di funzione e ripristinati successivamente, quando (terminata la funzione) gli argument register vengono svuotati dei valori temporanei.

^896940
---



