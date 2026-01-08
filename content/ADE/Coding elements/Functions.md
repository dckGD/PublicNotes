Le funzioni servono per organizzare il codice in modo da: evitare ripetizioni, permettere la **modularità** e consentono il **riutilizzo** del codice.

---
### REGISTRI UTILI

Durante la chiamata di una funzione vengono utilizzati [[General Registers in RISC-V|registri]] specifici:

| Tipo             | Registri     | Descrizione                           |
| ---------------- | ------------ | ------------------------------------- |
| Argomenti        | `a0` – `a7`  | Argomenti passati alla funzione       |
| Valori ritornati | `a0` – `a1`  | Valori restituiti dalla funzione      |
| Temporanei       | `t0` – `t6`  | Volatili (non devono essere salvati)  |
| Salvati          | `s0` – `s11` | Vanno salvati e ripristinati se usati |
| Return Addr      | `ra`         | Indirizzo di ritorno da una funzione  |
| Stack Ptr        | `sp`         | Puntatore allo stack                  |

---
### CHIAMARE UNA FUNZIONE

**Istruzione:**

`jal rd, label` (o più semplicemente `jal label`)

**Effetti:**

`rd ← PC + 4` → salva indirizzo di ritorno (next instruction)
`PC ← PC + etichetta` → salta alla funzione

**Convenzione:** 

si usa `jal ra, etichetta` per salvare il ritorno in `ra` (`x1`)

**Pseudoistruzione:** non si può usare j, in quanto non salva il ``ra``

---
### RITORNARE DA UNA FUNZIONE

**Istruzione:**

`jalr rd, offset(rs1)`

**Effetti:**

`rd ← PC + 4` → salva indirizzo di ritorno (se necessario)
`PC ← rs1 + offset` → salta all’indirizzo nel registro `rs1` (+ offset)

**Convenzione:** 

si usa `jalr x0, 0(ra)` per il ritorno → **nessun valore salvato**

**Pseudoistruzione:** [[Pseudoinstructions|jr rs]]
**Pseudoistruzione:** [[Pseudoinstructions|ret]]

---
### USO DELLO STACK
#### Quando usare lo [[Virtual Memory#STACK UTENTE (↓)|stack]] in una funzione:

**Salvare registri che verranno sovrascritti**: ad esempio, se la funzione usa registri come `s0-s11`, deve salvarli nello stack all’inizio e ripristinarli alla fine.
**Allocare spazio per variabili locali** se non bastano i registri.
**Passare parametri** se sono più di 8 (oltre `a0-a7`) ([[General Registers in RISC-V#^896940|overlap]]).
**Gestire il valore di ritorno** se si supera `a0`/`a1` (per tipi composti).
**Quando si chiamano altre funzioni** (funzioni nidificate o ricorsive).
**Salvare il return address (`ra`)**, se la funzione ne chiama un’altra.

---
#### Tabella registri callee/caller saved:

Ecco una tabella dettagliata dei registri integer di RISC-V, suddivisi in base alla convenzione di chiamata:

|Registro|Alias|Descrizione|Salvato da|
|---|---|---|---|
|x0|zero|Costante zero|—|
|x1|ra|Return address|Caller|
|x2|sp|Stack pointer|Callee|
|x3|gp|Global pointer|—|
|x4|tp|Thread pointer|—|
|x5–x7|t0–t2|Temporanei|Caller|
|x8|s0/fp|Saved register / Frame pointer|Callee|
|x9|s1|Saved register|Callee|
|x10–x11|a0–a1|Argomenti / Valori di ritorno|Caller|
|x12–x17|a2–a7|Argomenti|Caller|
|x18–x27|s2–s11|Saved registers|Callee|
|x28–x31|t3–t6|Temporanei|Caller|

**Caller-saved**: Il chiamante è responsabile di salvare questi registri se intende utilizzarli dopo una chiamata di funzione. (`a0–a7`, `t0–t6`, `ra` vanno salvati nella funzione chiamante)

**Callee-saved**: La funzione chiamata deve salvare e ripristinare questi registri se li utilizza. (`s0–s11`, `sp` vanno salvati nella funzione chiamata)

---
#### Come si usa lo stack:

##### All'inizio della funzione:

**Allocare spazio** sullo stack:

```assembly
addi sp, sp, -12      # Alloca 12 byte sullo stack
```

**Salvare i registri** che verranno usati (come `ra`, `a0`, `a1`, `s0`, ecc.):

```assembly
sw ra, 8(sp) 
sw a0, 4(sp) 
sw a1, 0(sp)
```

---
##### Alla fine della funzione (in ordine inverso):

**Ripristinare i registri** salvati:

```assembly
lw a1, 0(sp) 
lw a0, 4(sp) 
lw ra, 8(sp)
```

**Deallocare lo spazio**:

```assembly
addi sp, sp, 12
```

**Ritornare al chiamante**:

```assembly
jr ra
```
##### Esempio:

```assembly
funzione:
	
    addi sp, sp, -16       # alloco spazio
    sw   ra, 12(sp)        # salvo ra
    sw   s0, 8(sp)         # salvo s0 (callee-saved)
    sw   a0, 4(sp)         # salvo argomento a0
    sw   a1, 0(sp)         # salvo argomento a1
	
    addi s0, sp, 16        # uso s0 come frame pointer (opzionale)
	
	...                    # eventuale corpo dell funzione
	
    lw   a1, 0(sp)         # ripristino argomenti
    lw   a0, 4(sp)
    lw   s0, 8(sp)         # ripristino s0
    lw   ra, 12(sp)        # ripristino ra
    addi sp, sp, 16        # dealloco lo stack
    jr ra                  # ritorno (oppure con ret)
```

---
#### Cosa succede quando viene chiamata una funzione:

**La funzione chiamante (caller)**:

- Passa gli **argomenti nei registri `a0–a7`**, e se ce ne sono di più, li scrive nello **stack**.
- **Salva** eventuali **registri temporanei (`t0–t6`)** se vuole conservarli dopo la chiamata.
- **Chiama** la funzione con `jal`, salvando l’indirizzo di ritorno in `ra`.

**La funzione chiamata (callee)**:

- **Alloca lo stack frame**: sposta `sp` per creare spazio.
- **Salva `ra`** e **i registri `s`** se li userà (registri “salvati”).
- Se serve, **salva `s0`** e lo usa come **frame pointer (`fp`)** per accedere comodamente al frame.
- All’interno dello stack frame, **organizza le informazioni** secondo lo **schema dell’activation record**:

```r
	↑ indirizzi di memoria crescenti
+-----------------------------+  ← (frame pointer s0)
| Argomenti oltre a a0–a7     |  ← Argomenti passati attraverso lo stack
+-----------------------------+
| Variabili locali            |  ← Variabili locali (se presenti)
+-----------------------------+
| Registri salvati (s0, s1…)  |  ← Salvataggio dei registri "salvati" 
+-----------------------------+
| Return Address (ra)         |  ← Indirizzo di ritorno 
+-----------------------------+
| FP del chiamante (s0)       |  ← (frame pointer) del chiamante, salvato
+-----------------------------+  ← (stack pointer nuovo sp)
    ↓ indirizzi di memoria decrescenti
```

---
#### LIFO

Quando chiami più funzioni **senza chiudere (ritornare da) una prima dell’altra**, i **frame dello stack** vengono **impilati** in sequenza, uno sotto l'altro. Ogni funzione chiamata **aggiunge un nuovo frame** allo stack, e questo è esattamente il motivo per cui lo stack è implementato come una **struttura LIFO (Last In, First Out)**.

---
##### Esempio:

**Funzione principale (Main)**:

Quando il programma inizia, lo stack pointer (`sp`) è inizializzato a un valore predefinito, che punta a un indirizzo alto nella memoria (tipicamente vicino all'inizio della RAM).

**Chiamata alla prima funzione**:

Supponiamo che la funzione principale chiami la funzione `funzione1`.
- Viene **allocato spazio** per il frame di `funzione1` (salvataggio dei registri, parametri, ecc.).
- Lo stack cresce verso il basso, e `sp` viene decrementato.

```assembly
addi sp, sp, -12  # sp punta ora all'inizio del frame di funzione1 
sw   ra, 8(sp)    # Salva il return address di funzione1 
sw   a0, 4(sp)    # Salva il parametro a0 per funzione1 
sw   a1, 0(sp)    # Salva il parametro a1 per funzione1
```

**Chiamata alla seconda funzione (funzione2)**:

Supponiamo che `funzione1` chiami la funzione `funzione2`.
- **Un nuovo frame** viene **allocato sopra quello di `funzione1`**.
- Lo stack cresce ulteriormente verso il basso, e `sp` viene nuovamente decrementato.

```assembly
addi sp, sp, -12  # sp punta ora all'inizio del frame di funzione2 
sw   ra, 8(sp)    # Salva il return address di funzione2 
sw   a0, 4(sp)    # Salva il parametro a0 per funzione2 
sw   a1, 0(sp)    # Salva il parametro a1 per funzione2
```

**Ritorno dalle funzioni**:

Quando `funzione2` termina, il ritorno (`ret`) fa in modo che il controllo torni a `funzione1`. Il **frame di `funzione2`** viene **"popolato"** dallo stack (i dati vengono ripristinati da `sp`, e `sp` viene incrementato per liberare lo spazio).

Dopo il ritorno da `funzione2`, lo stack è tornato al punto dove si trovava quando era stata chiamata `funzione1`.

```
lw   a1, 0(sp)    # Ripristina a1 per funzione2 
lw   a0, 4(sp)    # Ripristina a0 per funzione2
lw   ra, 8(sp)    # Ripristina il return address per funzione2 
addi sp, sp, 12   # Dealloca lo spazio per funzione2 
ret               # Torna a funzione1
```

Lo stesso processo avviene quando `funzione1` termina e torna alla funzione principale.

---