Si verificano quando la pipeline non sa ancora quale sarà la prossima istruzione da eseguire a causa di un **branch (salto condizionato o incondizionato)** o di un salto (jump). Questo succede perché la decisione sul flusso di controllo viene presa solo in fasi successive della pipeline, quindi può essere necessario attendere o correggere la pipeline.

---
### ESEMPIO DI CONTROL HAZARD

Immaginiamo un processore con ciclo di clock di 200ps

E consideriamo il seguente codice:

```
beq t0, t1, Label    # salto condizionato 
add t2, t3, t4       # istruzione successiva
```

La decisione del salto viene presa in fase EX di `beq` ma il PC viene aggiornato (senza [[Datapath Pipeline#IMPLEMENTAZIONE CON ANTICIPAZIONE DEI SALTI|implementazioni]] aggiuntive) solo **dopo** il 4° stadio (**\\**) dell'istruzione di salto, dunque la pipeline inizia a caricare `add t2, t3, t4`  (fase IF) prima di sapere se il branch `beq t0, t1, Label` è preso o no:

| ISTRUZIONE          | 100ps | 200ps | 300ps  | 400ps  | 500ps | 600ps | 700ps | 800ps | 900ps | 1000ps | 1100ps | 1200ps |
| ------------------- | ----- | ----- | ------ | ------ | ----- | ----- | ----- | ----- | ----- | ------ | ------ | ------ |
| `beq t0, t1, Label` | IF    | IF    | ID     | ID     | *EX*  | *EX*  | ==\== | ==\== | \     | \      |        |        |
| `add t2, t3, t4`    |       |       | ==IF== | ==IF== | ID    | ID    | EX    | EX    | \     | \      | WB     | WB     |

Se il branch è preso, la `add` caricata in IF al ciclo 2 è sbagliata e non va eseguita, vediamo come fare (Non esistono vere e proprie correzioni delle criticità relative ai salti ma esistono alcune soluzioni che possono ridurre i ritardi causati dagli stessi).

---
### SOLUZIONI

#### Flush delle istruzioni successive al salto

Vengono comunque caricate le istruzioni ([[Execution Steps#1. (IF) FETCH|Fetch]]) e vengono **cancellate (flush)** se il salto è preso.

**Esempio:**

```assembly
beq t0, t1, Label    # salto condizionato 
add t2, t3, t4       # istruzione successiva
```

Si procede al **flush** di `add t2, t3, t4` se si verifica la condizione del salto:

| ISTRUZIONE          | 100ps | 200ps | 300ps          | 400ps          | 500ps  | 600ps  | 700ps  | 800ps  | 900ps  | 1000ps | 1100ps | 1200ps |
| ------------------- | ----- | ----- | -------------- | -------------- | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ |
| `beq t0, t1, Label` | IF    | IF    | ID             | ID             | *EX*   | *EX*   | ==\==  | ==\==  | \      | \      |        |        |
| `add t2, t3, t4`    |       |       | ==IF== (flush) | ==IF== (flush) | bubble | bubble | bubble | bubble | bubble | bubble | bubble | bubble |

In questo modo `add t2, t3, t4` non viene eseguita (inserimento di [[Pseudoinstructions#ISTRUZIONE `nop`|nop]]) (viene eseguita solo la fase di IF, che non arreca cambiamenti al programma).

---
#### Branch stall

Si **blocca la pipeline** con cicli d'attesa (bubble) finché non si conosce il risultato del salto. 

**Esempio:**

```assembly
beq t0, t1, Label    # salto condizionato 
add t2, t3, t4       # istruzione successiva
```

Si procede al **flush** di `add t2, t3, t4` se si verifica la condizione del salto:

| ISTRUZIONE          | 100ps | 200ps | 300ps          | 400ps          | 500ps | 600ps | 700ps | 800ps | 900ps | 1000ps | 1100ps | 1200ps |
| ------------------- | ----- | ----- | -------------- | -------------- | ----- | ----- | ----- | ----- | ----- | ------ | ------ | ------ |
| `beq t0, t1, Label` | IF    | IF    | ID             | ID             | *EX*  | *EX*  | ==\== | ==\== | \     | \      |        |        |
| `add t2, t3, t4`    |       |       | ==IF== (flush) | ==IF== (flush) | ID    | ID    | EX    | EX    | \     | \      | WB     | WB     |

Per evitare il flush dell'istruzione `add t2, t3, t4` , si possono inserire uno o più cicli di stallo (in questo caso 3) così da ritardare l'inizio dell'esecuzione della stessa ([[Execution Steps#1. (IF) FETCH|IF]]) fino all'aggiornamento corretto del [[Execution Steps#6. (AGGIORNAMENTO DEL PC)|PC]] da parte di `beq t0, t1, Label` (dopo il 4°cc):

| ISTRUZIONE          | 100ps | 200ps | 300ps  | 400ps  | 500ps  | 600ps  | 700ps  | 800ps  | 900ps  | 1000ps | 1100ps | 1200ps | 1300ps | 1400ps | 1500ps | 1600ps | 1700ps | 1800ps |
| ------------------- | ----- | ----- | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ |
| `beq t0, t1, Label` | IF    | IF    | ID     | ID     | *EX*   | *EX*   | ==\==  | ==\==  | \      | \      |        |        |        |        |        |        |        |        |
| **stall**           |       |       | bubble | bubble | bubble | bubble | bubble | bubble | bubble | bubble | bubble | bubble |        |        |        |        |        |        |
| **stall**           |       |       |        |        | bubble | bubble | bubble | bubble | bubble | bubble | bubble | bubble | bubble | bubble |        |        |        |        |
| **stall**           |       |       |        |        |        |        | bubble | bubble | bubble | bubble | bubble | bubble | bubble | bubble | bubble | bubble |        |        |
| `add t2, t3, t4`    |       |       |        |        |        |        |        |        | ==IF== | ==IF== | ID     | ID     | EX     | EX     | \      | \      | WB     | WB     |

---
#### Anticipare la decisione sul salto 

Ottimizzazione hardware per **ridurre il numero di stall**. 

**Esempio:**

```assembly
beq t0, t1, Label    # salto condizionato 
add t2, t3, t4       # istruzione successiva
```

Si procede al **flush** di `add t2, t3, t4` se si verifica la condizione del salto:

| ISTRUZIONE          | 100ps | 200ps | 300ps          | 400ps          | 500ps | 600ps | 700ps | 800ps | 900ps | 1000ps | 1100ps | 1200ps |
| ------------------- | ----- | ----- | -------------- | -------------- | ----- | ----- | ----- | ----- | ----- | ------ | ------ | ------ |
| `beq t0, t1, Label` | IF    | IF    | ID             | ID             | *EX*  | *EX*  | ==\== | ==\== | \     | \      |        |        |
| `add t2, t3, t4`    |       |       | ==IF== (flush) | ==IF== (flush) | ID    | ID    | EX    | EX    | \     | \      | WB     | WB     |

E' necessario spostare sia la logica del confronto (`t0 == t1` nel caso di `beq`) che l'aggiornamento del [[Execution Steps#6. (AGGIORNAMENTO DEL PC)|PC]] alla fase [[Execution Steps#2. (ID) DECODE|ID]]. Richiede un **costo hardware** maggiore, ma migliora il flusso (meno flush):

| ISTRUZIONE          | 100ps | 200ps | 300ps          | 400ps          | 500ps | 600ps | 700ps | 800ps | 900ps | 1000ps | 1100ps | 1200ps |
| ------------------- | ----- | ----- | -------------- | -------------- | ----- | ----- | ----- | ----- | ----- | ------ | ------ | ------ |
| `beq t0, t1, Label` | IF    | IF    | ==*ID*==       | ==*ID*==       | EX    | EX    | \     | \     | \     | \      |        |        |
| `add t2, t3, t4`    |       |       | ==IF== (flush) | ==IF== (flush) | ID    | ID    | EX    | EX    | \     | \      | WB     | WB     |

Ho bisogno quindi di inserire un solo stallo se voglio evitare i flush di `add t2, t3, t4` (senza l'anticipazione ne avrei dovuti inserire 3, guarda [[Control Hazard#Branch stall|Branch stall]]).

Leggi [[Datapath Pipeline#IMPLEMENTAZIONE CON ANTICIPAZIONE DEI SALTI|qui]] per l'implementazione hardware dell'anticipazione dei salti.

---
#### Delay Slot (ritardare il salto)

Si **colloca un’istruzione utile subito dopo** la `beq` (non sempre possibile). Si assume che l’istruzione subito dopo il salto **venga sempre eseguita**, sia che il salto sia preso o meno, questo evita di inserire bubble: la delay slot (l'istruzione da eseguire sempre) sostituisce lo stall.

**Esempio:**

```assembly
beq t0, t1, Label    # salto condizionato 
add t2, t3, t4       # istruzione successiva
```

Si procede al **flush** di `add t2, t3, t4` se si verifica la condizione del salto:

| ISTRUZIONE          | 100ps | 200ps | 300ps          | 400ps          | 500ps | 600ps | 700ps | 800ps | 900ps | 1000ps | 1100ps | 1200ps |
| ------------------- | ----- | ----- | -------------- | -------------- | ----- | ----- | ----- | ----- | ----- | ------ | ------ | ------ |
| `beq t0, t1, Label` | IF    | IF    | ID             | ID             | *EX*  | *EX*  | ==\== | ==\== | \     | \      |        |        |
| `add t2, t3, t4`    |       |       | ==IF== (flush) | ==IF== (flush) | ID    | ID    | EX    | EX    | \     | \      | WB     | WB     |

Si potrebbe inserire dunque uno stall ma, al fine di non "sprecare" un ciclo di clock, si può inserire una o più **delay slot**:

```assembly
beq t0, t1, Label    # salto condizionato 
addi t5, t5, 1       # delay slot 1: viene sempre eseguita
addi t6, t6, 1       # delay slot 2: viene sempre eseguita
add t2, t3, t4       # istruzione successiva
```

| ISTRUZIONE          | 100ps | 200ps | 300ps | 400ps | 500ps | 600ps | 700ps          | 800ps          | 900ps | 1000ps | 1100ps | 1200ps | 1300ps | 1400ps | 1500ps | 1600ps |
| ------------------- | ----- | ----- | ----- | ----- | ----- | ----- | -------------- | -------------- | ----- | ------ | ------ | ------ | ------ | ------ | ------ | ------ |
| `beq t0, t1, Label` | IF    | IF    | ID    | ID    | *EX*  | *EX*  | ==\==          | ==\==          | \     | \      |        |        |        |        |        |        |
| `addi t5, t5, 1`    |       |       | IF    | IF    | ID    | ID    | EX             | EX             | \     | \      | WB     | WB     |        |        |        |        |
| `addi t6, t6, 1`    |       |       |       |       | IF    | IF    | ID             | ID             | EX    | EX     | \      | \      | WB     | WB     |        |        |
| `add t2, t3, t4`    |       |       |       |       |       |       | ==IF== (flush) | ==IF== (flush) | ID    | ID     | EX     | EX     | \      | \      | WB     | WB     |

Si ritarda così  così l'inizio dell'esecuzione di `add t2, t3, t4` ([[Execution Steps#1. (IF) FETCH|IF]]) fino all'aggiornamento corretto del [[Execution Steps#6. (AGGIORNAMENTO DEL PC)|PC]] (dopo il 4°cc), e se si volesse evitare il flush di `add t2, t3, t4` si dovrebbe inserire un solo stallo (senza le delay slot ne avrei dovuti inserire 3, guarda [[Control Hazard#Branch stall|Branch stall]]).

>*N.B. Ovviamente non avviene il **flush** di `addi t5, t5, 1` e `addi t6, t6, 1`, dunque, per far si che questa strategia sia valida tale delay slot devono essere utili al programma (in questo caso potrebbero essere l'aggiornamento di indirizzi in un ciclo).*

---
#### Branch Prediction (previsione del salto)

Si **indovina se il salto sarà preso o meno**, e si prosegue il flusso previsto. Se si sbaglia, si annulla tutto.  Si **evita lo stallo** nella maggior parte dei casi e, se la predizione è corretta, la pipeline continua senza interruzioni. Se però si sbaglia, bisogna **flushare** le istruzioni errate e **ripartire dal PC corretto** (perdita di tempo).

**Tipi di predizione:**

**Predizione statica:** fissa e semplice: ad esempio, si assume sempre "salto non preso" (`not taken`) oppure "salto preso". Oppure si basa su convenzioni:

- _Backward branch_ (verso il passato, tipico dei loop) → preso.    
- _Forward branch_ → non preso.

**Predizione dinamica:** la CPU **osserva il comportamento passato** dei salti e costruisce una statistica. Si usano **tabelle** con 1 o più bit per predire.

---
### CONFRONTO

| Strategia                | Tipo | Vantaggi                         | Svantaggi                                                    | Fasi    |
| ------------------------ | ---- | -------------------------------- | ------------------------------------------------------------ | ------- |
| **Flush**                | HW   | Facile da implementare           | Bassa efficienza (possibile **fetch** di istruzioni inutili) | EX > IF |
| **Branch Stall**         | HW   | Facile da implementare           | Bassa efficienza (pipeline ferma dopo ogni branch)           | EX > IF |
| **Anticipare decisione** | HW   | Meno bubble semplice             | Serve hardware più veloce                                    | ID > IF |
| **Delay Slot**           | SW   | Niente bubble se si usa bene     | Difficile da gestire                                         | EX > IF |
| **Predizione statica**   | HW   | Facile, veloce se salto semplice | Poco precisa                                                 | IF > IF |
| **Predizione dinamica**  | HW   | Alta efficienza, si adatta       | Complessità hardware                                         | IF > IF |

---