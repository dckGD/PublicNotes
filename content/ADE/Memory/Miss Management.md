Vediamo come avviene la gestione di una [[Miss|miss]] in fase di esecuzione di un programma.

---
### 1. RILEVAMENTO DELLA MISS

L’unità di controllo della cache verifica per ogni accesso se il dato richiesto è presente (hit) o assente (miss). In caso di miss, l’unità di controllo deve intervenire avviando la procedura di risoluzione.

In una cache, un **accesso può causare un miss per tre motivi fondamentali**: 

---
#### 1. Cold (Compulsory) Miss

Il blocco **non è mai stato caricato prima**, è vuoto: [[Cache#^3ebbe6|bit di validità]] = 0 (inevitabile alla **prima richiesta** di un dato).

---
#### 2. Conflict Miss

Il blocco è **stato caricato in cache ma sovrascritto** a causa della **limitata associatività**. Succede **solo in cache non completamente associative**: 

- Causa: blocco già scritto in una **[[Cache#CACHE A MAPPATURA DIRETTA|cache direct-mapped]]**
- Causa: set pieno in una **[[Cache#CACHE SET-ASSOCIATIVE|cache set-associative]]**

>In una **fully-associative cache**, se tra due accessi a quel blocco sono stati richiesti **meno di `W × S` blocchi diversi (totale dei blocchi della cash**, allora il secondo accesso sarebbe stato **un hit**.

---
#### 3. Capacity Miss

La cache **non è abbastanza grande** per contenere tutti i blocchi richiesti. Anche con associatività massima (fully-associative), se sono stati richiesti più di `W × S` blocchi, **il blocco viene eliminato**.

---
### 2. STALLO DELLA PIPELINE

Durante una miss, il processore va in [[Data Hazard#Stallo della pipeline|stallo]]: tutti i registri temporanei e gli stati visibili al programmatore vengono congelati. Il processore resta in attesa finché il dato richiesto non viene [[Memory Hierarchy#RICERCA DEI DATI|recuperato]] dalla memoria.

- Nei processori in-order, tutte le istruzioni successive entrano in stallo.
- Nei processori out-of-order, è possibile eseguire altre istruzioni non dipendenti dal dato in attesa.

---
### 3. ACCESSO ALLA MEMORIA PRINCIPALE

L’unità di controllo della cache richiede il blocco di dati mancante alla memoria principale o a un livello di cache inferiore. L’accesso alla memoria principale è molto più lento rispetto alla cache (richiede più cicli di clock).

---
### 4. AGGIORNAMENTO DELLA CHACHE

Una volta che il dato richiesto è stato letto dalla memoria principale, viene scritto nella cache in corrispondenza della linea/set appropriata.

- Il [[Cache#^a0ea16|tag]] della linea/set viene aggiornato per riflettere il nuovo dato memorizzato.
- Il [[Cache#^3ebbe6|bit di validità]] viene impostato a “valido”. ([[Cache#ESEMPIO DI RICERCA NELLA CACHE (BLOCCHI DA 1 BYTE)|esempio]])

---
#### Politiche di rimpiazzo:

Quando si verifica un **miss** in una cache set-associativa o completamente associativa, può dipendere da **[[Miss Management#1. RILEVAMENTO DELLA MISS|diversi fattori]]**. Le **politiche di rimpiazzo** decidono **quale blocco eliminare** in caso di miss: Quando un **set è pieno** e deve essere caricato un nuovo blocco, si applica una politica di rimpiazzo per decidere **quale blocco eliminare**:

- **LRU ([[Località Temporale|località temporale]]) - Least Recently Used**: sostituisce il blocco usato meno recentemente. 
- **LFU ([[Località Spaziale|località spaziale]]) - Least Frequently Used**: sostituisce il blocco usato meno frequentemente.
- **Random**: sostituisce un blocco a caso (o in sequenza circolare).

---
### 5. RIPRESA DELL'ESECUZIONE

Quando il dato è disponibile nella cache, il processore può riprendere l’esecuzione dell’istruzione interrotta dalla miss ([[Datapath Single-Cycle#Program Counter (PC)|PC]] - 4). Se si trattava di una miss sulle istruzioni, il registro delle istruzioni viene aggiornato con la nuova istruzione letta dalla memoria.

---

