Il **datapath** è l’insieme dei componenti hardware della CPU (registri, ALU, multiplexer, bus, ecc.) che **elabora i dati** eseguendo operazioni aritmetiche, logiche e di trasferimento.

---
### ESEMPIO DI FUNZIONAMENTO

Il datapath:

- Prende un'**istruzione** (es. `add x1, x2, x3`)
- Recupera i **registri sorgente** (x2 e x3)
- Esegue l'**operazione** con l’ALU
- Scrive il **risultato** nel registro di destinazione (x1)

---
### DATAPATH SINGLE-CYCLE VS PIPELINE

**[[Datapath Single-Cycle|Singolo ciclo]]**: ogni istruzione viene completata in **un solo ciclo di clock**  
→ più semplice, ma inefficiente

**[[Datapath Pipeline|Pipeline]]**: le istruzioni sono suddivise in **più fasi**, ognuna in un ciclo diverso  
→ più complesso, ma più efficiente

---
#### Differenza di funzionamento

**Ciclo singolo:**

- Tutta l’istruzione viene eseguita in **un solo ciclo di clock**.
- La **durata del ciclo di clock è pari alla somma dei tempi massimi di tutte le fasi**.
- Anche se un’istruzione non usa tutti i componenti (es. `R-type` non accede alla memoria), il tempo viene comunque “sprecato”. 

---

**Pipeline**

- Le istruzioni sono suddivise in **5 stadi**, uno per ciascuna fase (IF, ID, EX, MEM, WB).
- Ogni stadio richiede il **suo tempo specifico**, ma la **frequenza di clock è determinata dallo stadio più lento**.
- Dopo una latenza iniziale, una nuova istruzione entra **ogni ciclo** → throughput elevato.

---
#### Vantaggi e svantaggi

| **Aspetto**              | **Ciclo unico**                                                                 | **Pipeline**                                                                                      |
| ------------------------ | ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| **Semplicità**           | ✅ Architettura semplice, facile da progettare e testare                         | ❌ Architettura complessa: richiede gestione di hazard (RAW, WAW, WAR), forwarding, stalli e flush |
| **Prestazioni**          | ❌ Prestazioni basse: ogni istruzione impiega l’intero ciclo più lungo           | ✅ Prestazioni elevate: throughput migliorato grazie all'esecuzione parallela                      |
| **Periodo di clock**     | ❌ Lento: determinato dall’istruzione più lunga (es. `lw`)                       | ✅ Veloce: determinato solo dallo stadio più lento (es. IF o MEM)                                  |
| **Efficienza temporale** | ❌ Poco efficiente: ogni istruzione “spreca” stadi non utilizzati                | ✅ Maggiore efficienza: ogni stadio lavora ogni ciclo su un’istruzione diversa                     |
| **Utilizzo della CPU**   | ❌ Risorse hardware (ALU, memoria, registri) spesso inattive per parte del ciclo | ✅ Uso intensivo delle risorse: ogni componente lavora quasi ogni ciclo                            |
| **Throughput**           | ❌ Una istruzione ogni ciclo (lento)                                             | ✅ Una istruzione completata ogni ciclo (dopo riempimento pipeline)                                |
| **Tempo di esecuzione**  | ❌ Cresce linearmente con il numero di istruzioni × tempo massimo                | ✅ Molto ridotto grazie al parallelismo, vicino a: `clock × (n + stadi − 1)`                       |

---
#### Esempio

Immaginiamo un processore che impiega i seguenti tempi (ps) per eseguire le 4 tipologie di istruzione nella tabella:

| ISTRUZIONE | IF    | ID    | EX    | MEM   | WB    | TOT   |
| ---------- | ----- | ----- | ----- | ----- | ----- | ----- |
| Load word  | 200ps | 100ps | 200ps | 200ps | 100ps | 800ps |
| Store word | 200ps | 100ps | 200ps | 200ps |       | 700ps |
| R-type     | 200ps | 100ps | 200ps |       | 100ps | 600ps |
| Branch     | 200ps | 100ps | 200ps |       |       | 500ps |
>*N.B. non tutte le istruzioni necessitano di tutte le fasi (ad esempio le R-type saltano la fase MEM, ovviamente) per questo hanno tempi di esecuzione diversi.*

Quindi andiamo ad analizzare il tempo impiegato per eseguire questo breve programma, prima con un datapath a single-cycle e poi un datapath a pipeline:

```assembly
add t0, t2, t3        # R-type
lw t1, (s0)           # Load word (I-type)
beq t0, t1, Label     # Branch (B-type)
```

**Uso di datapath a single-cycle:**

**Periodo di clock:** tempo dell'istruzione più lenta (`lw`) = 800 ps
**Throughput:** una sola istruzione per ciclo di clock
**Tempo di esecuzione totale del programma:** (800 + 800 + 800) ps = 2400 ps

| ISTRUZIONE          | 100ps | 200ps | 300ps | 400ps | 500ps | 600ps | 700ps | 800ps | 900ps | 1000ps | 1100ps | 1200ps | 1300ps | 1400ps | 1500ps | 1600ps | 1700ps | 1800ps | 1900ps | 2000ps | 2100ps | 2200ps | 2300ps | 2400ps |
| ------------------- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ |
| `add t0, t2, t3`    | IF    | IF    | ID    | EX    | EX    | \     | \     | WB    |       |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |
| `lw t1, (s0)`       |       |       |       |       |       |       |       |       | IF    | IF     | ID     | EX     | EX     | MEM    | MEM    | WB     |        |        |        |        |        |        |        |        |
| `beq t0, t1, Label` |       |       |       |       |       |       |       |       |       |        |        |        |        |        |        |        | IF     | IF     | ID     | EX     | EX     | \      | \      | \      |

**Uso di datapath a pipeline:**

**Periodo di clock:** tempo dello stadio più lento (`IF`/`EX`/`MEM`) = 200 ps
**Throughput:** fino a 3 istruzioni nello stesso ciclo di clock (aumentato)
**Tempo di esecuzione totale del programma:** (200 + 200 + 1000) ps = 1400 ps

Cambiano dunque i tempi di esecuzione delle varie istruzioni (ogni stadio va allineato e tutti durano 200ps):

| ISTRUZIONE | IF    | ID    | EX    | MEM     | WB      | TOT    |
| ---------- | ----- | ----- | ----- | ------- | ------- | ------ |
| Load word  | 200ps | 200ps | 200ps | 200ps   | 200ps   | 1000ps |
| Store word | 200ps | 200ps | 200ps | 200ps   | (200ps) | 1000ps |
| R-type     | 200ps | 200ps | 200ps | (200ps) | 200ps   | 1000ps |
| Branch     | 200ps | 200ps | 200ps | (200ps) | (200ps) | 1000ps |

| ISTRUZIONE          | 100ps | 200ps | 300ps | 400ps | 500ps | 600ps | 700ps | 800ps | 900ps | 1000ps | 1100ps | 1200ps | 1300ps | 1400ps |
| ------------------- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ------ | ------ | ------ | ------ | ------ |
| `add t0, t2, t3`    | IF    | IF    | ID    | ID    | EX    | EX    | \     | \     | WB    | WB     |        |        |        |        |
| `lw t1, (s0)`       |       |       | IF    | IF    | ID    | ID    | EX    | EX    | MEM   | MEM    | WB     | WB     |        |        |
| `beq t0, t1, Label` |       |       |       |       | IF    | IF    | ID    | ID    | EX    | EX     | \      | \      | \      | \      |

>*(non si tiene conto di [[Hazard]])*

---