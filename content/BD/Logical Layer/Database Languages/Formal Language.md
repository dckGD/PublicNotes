Un linguaggio formale nell'ambito dei DB relazionali, consiste di un insieme di operatori che possono essere applicati a una (operatori unari) o due (operatori binari) istanze di relazione e forniscono come risultato una nuova istanza di relazione.

Un linguaggio formale può essere a sua volta:

---
### LINGUAGGIO PROCEDURALE

Dice **come ottenere** un risultato.  
L’utente deve **specificare i passi operativi**, l’ordine e le operazioni da eseguire.

**Esempio:** **[[Relational Algebra|algebra relazionale]]**.

---

**Caratteristiche principali:**

- Descrive **la procedura**, non solo il risultato.
- L’utente controlla _come_ il DB lavora.
- Più vicino alla **programmazione imperativa**.
- Meno astratto, più dettagliato.

---
### LINGUAGGIO DICHIARATIVO

Dice **cosa ottenere**, non **come ottenerlo**.  
L’utente **descrive il risultato desiderato**, e il **DBMS decide i passi interni** per calcolarlo.

**Esempio:** Linguaggio **[[SQL]]**, **calcolo relazionale**.

---

**Caratteristiche principali:**

- Descrive **la condizione o proprietà** del risultato.
- L’utente non controlla l’ordine delle operazioni.
- Più alto livello, più astratto.
- Il DBMS può **ottimizzare automaticamente** l’esecuzione.

---
