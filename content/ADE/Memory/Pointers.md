In **RISC-V**, i **puntatori** sono dei registri che contengono indirizzi di memoria. Poiché RISC-V è un'architettura **load/store**, tutte le operazioni con la memoria avvengono tramite puntatori, usando istruzioni di caricamento (`lw`, `lb`, `ld`, ecc.) e memorizzazione (`sw`, `sb`, `sd`, ecc.).

---
### CONCETTI CHIAVE

**Indirizzamento** → Un puntatore contiene un **indirizzo di memoria**, non un dato direttamente

**De-referenziazione** → Tramite un puntatore, possiamo accedere o modificare il valore memorizzato all'indirizzo puntato.

**Gestione dinamica della memoria** → I puntatori permettono di allocare e liberare memoria in modo dinamico.

**Strutture dati avanzate** → Sono fondamentali per liste, alberi, grafi e altre strutture che necessitano di riferimenti flessibili.

---