Si verificano quando un’istruzione legge un registro **prima che venga scritto** da una precedente.

---
### ESEMPIO DI DATA HAZARD

Immaginiamo un processore con ciclo di clock di 200ps

E controlliamo il seguente codice:

```assembly
add s0, t0, t1    # s0 = t0 + t1 
sub t2, s0, t3    # t2 = s0 - t3   <-- RAW hazard!
```

Qui `sub` ha bisogno di `s0`, ma `s0` non è ancora stato scritto al momento dell’esecuzione:

| ISTRUZIONE       | 100ps | 200ps | 300ps | 400ps | 500ps  | 600ps  | 700ps | 800ps | 900ps  | 1000ps | 1100ps | 1200ps |
| ---------------- | ----- | ----- | ----- | ----- | ------ | ------ | ----- | ----- | ------ | ------ | ------ | ------ |
| `add s0, t0, t1` | IF    | IF    | ID    | ID    | EX     | EX     | \     | \     | ==WB== | ==WB== |        |        |
| `sub t2, s0, t3` |       |       | IF    | IF    | ==ID== | ==ID== | EX    | EX    | \      | \      | WB     | WB     |

L'istruzione `sub t2, s0, t3` non può essere eseguita finché l'istruzione `add s0, t0, t1` non esegue il [[Execution Steps#5. (WB) WRITE BACK|WB]] (finché non viene scritto il risultato della somma nel registro `s0`).

---
### SOLUZIONI

#### Stallo della pipeline

Inserimento di **cicli di attesa** (stall o bubble) quando una istruzione ha bisogno di un dato **non ancora disponibile**. 

**Esempio:**

```assembly
lw t2, 4(t0)
add t3, t1, t2    <-- RAW hazard!
```

>N.B. la CPU che teniamo in considerazione nell'esempio non ha implementazioni di [[Datapath Pipeline#IMPLEMENTAZIONE CON FORWARDING|forwarding]] di alcun tipo, dunque è necessario aspettare che i registri necessari vengano sempre scritti nella fase [[Execution Steps#5. (WB) WRITE BACK|WB]] prima di essere riutilizzati. 
>==Tuttavia è possibile sovrapporre a livello temporale le fasi ID e WB in quanto fanno riferimento allo stesso componente del datapath: il [[Datapath Single-Cycle#Register File|register file]], che viene scritto (WB) nella prima metà del ciclo di clock e letto ([[Execution Steps#2. (ID) DECODE|ID]]) nella seconda metà.==

Qui `add` ha bisogno di `t2`, ma `t2` non è ancora stato memorizzato al momento dell’esecuzione:

| ISTRUZIONE       | 100ps | 200ps | 300ps | 400ps | 500ps  | 600ps  | 700ps | 800ps | 900ps  | 1000ps | 1100ps | 1200ps |
| ---------------- | ----- | ----- | ----- | ----- | ------ | ------ | ----- | ----- | ------ | ------ | ------ | ------ |
| `lw t2, 4(t0)`   | IF    | IF    | ID    | ID    | EX     | EX     | MEM   | MEM   | ==WB== | ==WB== |        |        |
| `add t3, t1, t2` |       |       | IF    | IF    | ==ID== | ==ID== | EX    | EX    | \      | \      | WB     | WB     |

L'istruzione `add t3, t1, t2` non può essere eseguita finché l'istruzione `lw t2, 4(t0)` non esegue la [[Execution Steps#5. (WB) WRITE BACK|WB]] (finché non viene scritto il valore di `4(t0)` in `t2`).

Inseriamo quindi 2 cicli d'attesa così da permettere alla fase [[Execution Steps#2. (ID) DECODE|ID]]  (lettura) di `add` di accedere al registro `t2` **subito dopo** che `lw` lo ha scritto nel [[Execution Steps#5. (WB) WRITE BACK|WB]] (scrittura), sfruttando la divisione temporale in due metà (scrittura/lettura) del ciclo di clock:

| ISTRUZIONE       | 100ps | 200ps | 300ps  | 400ps  | 500ps  | 600ps  | 700ps  | 800ps  | 900ps  | 1000ps | 1100ps | 1200ps | 1300ps | 1400ps | 1500ps | 1600ps |
| ---------------- | ----- | ----- | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ |
| `lw t2, 4(t0)`   | IF    | IF    | ID     | ID     | EX     | EX     | MEM    | MEM    | ==WB== | WB     |        |        |        |        |        |        |
| **stall**        |       |       | bubble | bubble | bubble | bubble | bubble | bubble | bubble | bubble | bubble | bubble |        |        |        |        |
| **stall**        |       |       |        |        | bubble | bubble | bubble | bubble | bubble | bubble | bubble | bubble | bubble | bubble |        |        |
| `add t3, t1, t2` |       |       |        |        |        |        | IF     | IF     | ID     | ==ID== | EX     | EX     | \      | \      | WB     | WB     |

Leggi [[Datapath Pipeline#IMPLEMETNAZIONE CON STALL|qui]] per l'implementazione hardware degli stalli.

---
#### Forwarding (o bypassing)

Instradamento diretto dell’output dell’ALU alle istruzioni che ne hanno bisogno. 

**Esempio:**

```assembly
add s0, t0, t1    # s0 = t0 + t1 
sub t2, s0, t3    # t2 = s0 - t3   <-- RAW hazard!
```

L'istruzione `sub t2, s0, t3` (come nel caso sopra) non può essere eseguita finché l'istruzione `add s0, t0, t1` non esegue il [[Execution Steps#5. (WB) WRITE BACK|WB]] (finché non viene scritto il risultato della somma nel registro `s0`):

| ISTRUZIONE       | 100ps | 200ps | 300ps | 400ps | 500ps  | 600ps  | 700ps | 800ps | 900ps  | 1000ps | 1100ps | 1200ps |
| ---------------- | ----- | ----- | ----- | ----- | ------ | ------ | ----- | ----- | ------ | ------ | ------ | ------ |
| `add s0, t0, t1` | IF    | IF    | ID    | ID    | EX     | EX     | \     | \     | ==WB== | ==WB== |        |        |
| `sub t2, s0, t3` |       |       | IF    | IF    | ==ID== | ==ID== | EX    | EX    | \      | \      | WB     | WB     |

Possiamo però effettuare il forwarding, ovvero creare una scorciatoia nel circuito in modo che non appena il risultato della somma viene generato dall'[[CPU Units#ALU (Arithmetic Logic Unit)|ALU]], quindi nella fase [[Execution Steps#3. (EX) EXECUTE|EX]] di `add s0, t0, t1`, questo può essere subito utilizzato come ingresso per la sottrazione (sempre nell'ALU) di  `sub t2, s0, t3`, nella sua di fase EX.
In questo modo il processore **non aspetta la fase WB**, ma **passa il risultato** della `add` alla `sub` **subito dopo EX** (appena calcolato dall'ALU):

| ISTRUZIONE       | 100ps | 200ps | 300ps | 400ps | 500ps  | 600ps  | 700ps  | 800ps  | 900ps | 1000ps | 1100ps | 1200ps |
| ---------------- | ----- | ----- | ----- | ----- | ------ | ------ | ------ | ------ | ----- | ------ | ------ | ------ |
| `add s0, t0, t1` | IF    | IF    | ID    | ID    | ==EX== | ==EX== | \      | \      | WB    | WB     |        |        |
| `sub t2, s0, t3` |       |       | IF    | IF    | ID     | ID     | ==EX== | ==EX== | \     | \      | WB     | WB     |

Leggi [[Datapath Pipeline#IMPLEMENTAZIONE CON FORWARDING|qui]] per l'implementazione hardware del forwarding.

---
#### Riordinamento del codice (scheduling delle istruzioni)

Cambio **dell’ordine delle istruzioni** per **dare tempo** alla pipeline di produrre i dati.

**Esempio:**

```assembly
lw t1, 0(t0)
lw t2, 4(t0)
add t3, t1, t2    <-- RAW hazard!
sw t3, 12(t0)
lw t4, 8(t0)
add t5, t1, t4    <-- RAW hazard!
sw t5, 16(t0)
```

>N.B. in questo esercizio teniamo conto di una CPU con [[Datapath Pipeline#IMPLEMENTAZIONE CON FORWARDING|forwarding]] tra fase [[Execution Steps#4. (MEM) MEMORY|MEM]] e fase [[Execution Steps#2. (ID) DECODE|ID]] in modo che un'istruzione può direttamente prelevare il valore di un registro direttamente in seguito alla fase MEM dell'istruzione che inizializza tale registro. Ad esempio: `add t3, t1, t2` può direttamente prendere il dato di `t2` dopo la fase MEM di `lw t2, 4(t0)` senza dover aspettare che quest'ultima scriva `t2` nei registri (fase [[Execution Steps#5. (WB) WRITE BACK|WB]]).

| Numero | ISTRUZIONE       | 100ps | 200ps | 300ps | 400ps | 500ps | 600ps | 700ps    | 800ps    | 900ps     | 1000ps    | 1100ps | 1200ps | 1300ps | 1400ps | 1500ps  | 1600ps  | 1700ps | 1800ps | 1900ps | 2000ps | 2100ps | 2200ps |
| ------ | ---------------- | ----- | ----- | ----- | ----- | ----- | ----- | -------- | -------- | --------- | --------- | ------ | ------ | ------ | ------ | ------- | ------- | ------ | ------ | ------ | ------ | ------ | ------ |
| 1      | `lw t1, 0(t0)`   | IF    | IF    | ID    | ID    | EX    | EX    | MEM      | MEM      | WB        | WB        |        |        |        |        |         |         |        |        |        |        |        |        |
| 2      | `lw t2, 4(t0)`   |       |       | IF    | IF    | ID    | ID    | EX       | EX       | *==MEM==* | *==MEM==* | WB     | WB     |        |        |         |         |        |        |        |        |        |        |
| 3      | `add t3, t1, t2` |       |       |       |       | IF    | IF    | *==ID==* | *==ID==* | EX        | EX        | \      | \      | WB     | WB     |         |         |        |        |        |        |        |        |
| 4      | `sw t3, 12(t0)`  |       |       |       |       |       |       | IF       | IF       | ID        | ID        | EX     | EX     | MEM    | MEM    | \       | \       |        |        |        |        |        |        |
| 5      | `lw t4, 8(t0)`   |       |       |       |       |       |       |          |          | IF        | IF        | ID     | ID     | EX     | EX     | ==MEM== | ==MEM== | WB     | WB     |        |        |        |        |
| 6      | `add t5, t1, t4` |       |       |       |       |       |       |          |          |           |           | IF     | IF     | ==ID== | ==ID== | EX      | EX      | \      | \      | WB     | WB     |        |        |
| 7      | `sw t5, 16(t0)`  |       |       |       |       |       |       |          |          |           |           |        |        | IF     | IF     | ID      | ID      | EX     | EX     | MEM    | MEM    | \      | \      |

Si potrebbero aggiungere stalli in presenza degli hazard, ma questo rallenterebbe l'esecuzione del programma, dunque conviene rivedere il codice scambiando l'ordine delle istruzioni in modo da prevenire criticità:

Si può provare a portare l'istruzione numero 5 in terza posizione:

| Numero | ISTRUZIONE       | 100ps | 200ps | 300ps | 400ps | 500ps | 600ps | 700ps | 800ps | 900ps     | 1000ps    | 1100ps  | 1200ps  | 1300ps | 1400ps | 1500ps | 1600ps | 1700ps | 1800ps | 1900ps | 2000ps | 2100ps | 2200ps |
| ------ | ---------------- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | --------- | --------- | ------- | ------- | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ |
| 1      | `lw t1, 0(t0)`   | IF    | IF    | ID    | ID    | EX    | EX    | MEM   | MEM   | WB        | WB        |         |         |        |        |        |        |        |        |        |        |        |        |
| 2      | `lw t2, 4(t0)`   |       |       | IF    | IF    | ID    | ID    | EX    | EX    | *==MEM==* | *==MEM==* | WB      | WB      |        |        |        |        |        |        |        |        |        |        |
| 5      | `lw t4, 8(t0)`   |       |       |       |       | IF    | IF    | ID    | ID    | EX        | EX        | ==MEM== | ==MEM== | WB     | WB     |        |        |        |        |        |        |        |        |
| 3      | `add t3, t1, t2` |       |       |       |       |       |       | IF    | IF    | *==ID==*  | *==ID==*  | EX      | EX      | \      | \      | WB     | WB     |        |        |        |        |        |        |
| 4      | `sw t3, 12(t0)`  |       |       |       |       |       |       |       |       | IF        | IF        | ID      | ID      | EX     | EX     | MEM    | MEM    | \      | \      |        |        |        |        |
| 6      | `add t5, t1, t4` |       |       |       |       |       |       |       |       |           |           | IF      | IF      | ==ID== | ==ID== | EX     | EX     | \      | \      | WB     | WB     |        |        |
| 7      | `sw t5, 16(t0)`  |       |       |       |       |       |       |       |       |           |           |         |         | IF     | IF     | ID     | ID     | EX     | EX     | MEM    | MEM    | \      | \      |

In questo modo eliminiamo tutti gli hazard: 
`add t3, t1, t2` prende `t2` direttamente dalla memoria RAM nel momento in cui `lw t2, 4(t0)` carica il valore nella fase [[Execution Steps#4. (MEM) MEMORY|MEM]] (allineamento di *MEM* e *ID*).
`add t5, t1, t4` prende `t4` direttamente dalla memoria RAM dopo che `lw t4, 8(t0)` carica il valore nella fase MEM (ID cronologicamente dopo MEM).

---
### CONFRONTO

| Tecnica        | Tipo | Vantaggio                   | Svantaggio                                      | Fasi               |
| -------------- | ---- | --------------------------- | ----------------------------------------------- | ------------------ |
| **Stall**      | HW   | Semplice da implementare    | Rallenta il programma                           | WB > ID            |
| **Forwarding** | HW   | Velocizza l’esecuzione      | Richiede logica hardware aggiuntiva             | EX > EX o MEM > EX |
| **Scheduling** | SW   | Usa al meglio le istruzioni | Il compilatore o il programmatore deve pensarci |                    |

>*N.B.  Quando si tratta di **reperire dati già memorizzati** (dati scritti nella **fase MEM o WB**) allora l'istruzione che li utilizza deve **aspettare** di eseguire la sua fase **ID** solo **dopo** che l’altra istruzione ha completato la scrittura (→ **si crea uno stallo**: MEM → ID o WB → ID). Quando invece si vuole **usare direttamente un valore appena calcolato**, senza attendere la sua memorizzazione (es. subito dopo la fase **EX**), si può fare **forwarding**: si prende il risultato direttamente dall’**ALU output** della prima operazione (fase **EX**) e lo si invia alla **EX** dell’istruzione che lo usa (→ **EX → EX**).*

---