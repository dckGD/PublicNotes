Il processore ([[CPU Units|CPU]]) è **molto più veloce** della memoria principale ([[RAM]]). Questo genera un calo di efficienza: la CPU può restare **inattiva** in attesa dei dati. Dunque, per ottimizzare le prestazioni, i calcolatori moderni utilizzano una **gerarchia di memoria**, organizzata su più livelli:

---
### GERARCHIA TIPICA (ES. RISC-V)

| Livello | Memoria                      | Tecnologia                                                                                             | Posizione                 | Velocità | Capacità | Costo per bit |
| ------: | ---------------------------- | ------------------------------------------------------------------------------------------------------ | ------------------------- | -------- | -------- | ------------- |
|  **L0** | **Registri CPU**             | **Flip-Flop** (bistabili)                                                                              | Interni alla CPU          | ✩✩✩✩✩✩   | ✩        | ✩✩✩✩✩✩        |
|  **L1** | Cache L1 (Istruzioni/Dati)   | **[[Memory Technologies#SRAM (STATIC RANDOM ACCESS MEMORY)\|SRAM]]**                                   | Interna alla CPU          | ✩✩✩✩✩    | ✩✩       | ✩✩✩✩✩         |
|  **L2** | Cache L2                     | **[[Memory Technologies#SRAM (STATIC RANDOM ACCESS MEMORY)\|SRAM]]**                                   | Interna o vicina alla CPU | ✩✩✩✩     | ✩✩✩      | ✩✩✩✩          |
|  **L3** | Cache L3                     | **[[Memory Technologies#SRAM (STATIC RANDOM ACCESS MEMORY)\|SRAM]]**                                   | Condivisa (tra più core)  | ✩✩✩      | ✩✩✩✩     | ✩✩✩           |
|  **L4** | RAM principale (DDR/LPDDR)   | **[[Memory Technologies#DRAM (DYNAMIC RANDOM ACCESS MEMORY)\|DRAM]]**                                  | Esterna alla CPU          | ✩✩       | ✩✩✩✩✩    | ✩✩            |
|  **L5** | Memoria secondaria (SSD/HDD) | **[[Memory Technologies#FLASH (SSD)\|Flash]] **/**[[Memory Technologies#MEMORIA A DISCO (HDD)\|HDD]]** | Molto distante            | ✩        | ✩✩✩✩✩✩   | ✩             |

---
### RICERCA DEI DATI

Quando la CPU cerca un dato in memoria discende tutta la gerarchia dalla memoria più vicina (e veloce) a quella più lontana (e lenta): 

1. Controlla nei **registri** → **Hit**? 
2. **Miss** → cerca in **Cache L1** → **Hit**? 
3. **Miss** → cerca in **Cache L2** → **Hit**? 
4. **Miss** → cerca in **Cache L3** → **Hit**? 
5. **Miss** → cerca in **RAM**
6. **Page fault** → accede al **disco/SSD**

> **Ogni livello più basso** ha **più dati ma è più lento**, e viene consultato **solo se necessario**.

---
#### 1. L0 Accesso ai registri

Se il dato è già in un **registro CPU**, l’accesso è immediato → **[[Hit]] nei registri** 
Se non è nei registri, la CPU genera un **indirizzo di memoria** per cercarlo altrove → si entra nella **gerarchia cache/memoria**.

---
#### 2. L1 Cache

La **cache controller** cerca nella **Cache L1**:
Ogni **[[Block|blocco]]** (linea di cache) ha un **[[Tag|tag]]** che identifica l’indirizzo originale da cui proviene.
Se il **tag combacia** con l’indirizzo richiesto → **Hit** in L1.
Se no → **[[Miss]]** → si prosegue nella Cache L2 (si carica l’intero blocco dal livello inferiore per sfruttare la **[[Località Spaziale|località spaziale]]**).

---
#### 3. L2 e L3 Cache

Il dato viene cercato in **L2**, poi eventualmente in **L3** (se presenti) , con lo stesso meccanismo.
**[[Hit Rate|Hit rate]]** elevato, ma latenza più alta rispetto a L1.
Ogni livello ha un **[[Miss Penalty|miss penalty]]** maggiore → più cicli sprecati se non si trova il dato.

---
#### 4. L4 RAM 

Se anche le cache hanno fallito (**Miss in L1, L2, L3**), si accede alla **RAM**.
Questo è **molto più lento**: si può perdere **decine di cicli**.
La RAM è organizzata a blocchi fisici, ma l'accesso è **random access**.
Si sfrutta la **[[Località Temporale|località temporale]]** (dato usato di recente sarà probabilmente riutilizzato) per ricaricare anche blocchi vicini.

---
#### 5. L5 Page fault e memoria secondaria (SSD/HDD)

Se il dato non è nemmeno in RAM (es. è stato spostato su SSD), si ha un **[[Page Fault|page fault]]**.
Il sistema operativo deve caricare la **pagina mancante dalla memoria secondaria** (es. SSD) → **[[Latency|latenza]] enorme** (fino a milioni di cicli). Dopo il caricamento, il dato viene **memorizzato nella RAM e nelle cache** per futuri accessi.

---