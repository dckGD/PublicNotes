Gli overflow sono fenomeni logici che si verificano generalmente nei file [[Random File|hash]] quando il numero di record in un bucket supera la **capacità massima** del bucket (in seguito quindi a più [[Collision|collisioni]] sul bucket). I record in eccesso devono essere memorizzati in blocchi aggiuntivi, aumentando il numero di **[[Block Access|block access]]** richiesti. Ne esistono due tipi:

---
### OPEN ADDRESSING / LINEAR PROBING

Quando un bucket è pieno e su di esso avviene una collisione, il nuovo record viene inserito nel **prossimo bucket libero** dell’area primaria (linear probing). Non serve dunque un’area separata di overflow. Tuttavia questo metodo può creare **collisioni a catena** e peggiorare la distribuzione dei record. 

---
#### Esempio

**Chiavi da inserire:** 12, 20, 28, 36, 44
**M** = 4 (volutamente scelto in modo errato, non primo e < NB)
**CAP** = 2 (record per bucket)

**Calcolo hash:**

12 → 12 mod 4 = 0 
20 → 20 mod 4 = 0 
28 → 28 mod 4 = 0 
36 → 36 mod 4 = 0 
44 → 44 mod 4 = 0 

**Mappatura nel file hash:

Tutti i record finiscono nello stesso bucket **B0**, dunque ci sono collisioni a raffica:

12 → B0 libero →  va in B0 : 1 RBA
20 → B0 ha un posto →  va in B0 : 1 RBA 
28 → B0 pieno → B1 libero→ va in B1 : 1 RBA + 1 SBA
36 → B0 pieno → B1 ha un posto → va in B1 : 1 RBA + 1 SBA
44 → B0 pieno → B1 pieno → B2 ha 1 posto → va in B2 : 1 RBA + 2 SBA

```powershell
FILE HASH
|
├─ BUCKET 0 [Blocco 1, Header: num_records=2]    ← pieno
|  ├─ Record: 12
|  └─ Record: 20
|
├─ BUCKET 1 [Blocco 2, Header: num_records=2]    ← usato per overflow
|  ├─ Record: 28
|  └─ Record: 36
|
├─ BUCKET 2 [Blocco 3, Header: num_records=1]    ← usato per overflow
|  └─ Record: 44
|
└─ BUCKET 3 [Blocco 4, Header: num_records=0]
```

---
### OVERFLOW AREA / CHAINING

Quando un bucket è pieno e su di esso avviene una collisione, i record in eccesso vengono memorizzati in **blocchi aggiuntivi esterni all’area primaria**. L’accesso a questi record richiede **uno o più Random Block Access (RBA) aggiuntivi**. I blocchi aggiuntivi sono collegati a catena al bucket principale attraverso puntatori (chaining).

---
#### Esempio

**Chiavi da inserire:** 12, 20, 28, 36, 44
**M** = 4 (volutamente scelto in modo errato, non primo e < NB)
**CAP** = 2 (record per bucket)

**Calcolo hash:**

12 → 12 mod 4 = 0 
20 → 20 mod 4 = 0 
28 → 28 mod 4 = 0 
36 → 36 mod 4 = 0 
44 → 44 mod 4 = 0 

**Mappatura nel file hash:

Tutti i record finiscono nello stesso bucket **B0**, dunque ci sono collisioni a raffica. Tuttavia ora, **quando B0 è pieno**, non andiamo in **B1, B2, B3** ma creiamo **blocchi di overflow in un'area separata collegati a catena**:

Supponiamo:

- **BUCKET 0 – 3** = area primaria (blocchi principali)
- **O1, O2, …** = blocchi di overflow in area separata (overflow area)

12 → B0 libero → va in B0 : 1 RBA 
20 → B0 ha un posto → va in B0 : 1 RBA
28 → B0 pieno → crea blocco O1 e collega B0 -> O1 → va in O1 : 2 RBA
36 → B0 pieno → O1 ha ancora posto → va in O1 : 2 RBA
44 → B0 pieno → O1 pieno → crea O2 e collega B0 -> O1 -> O2 → va in O2 : 3 RBA

```powershell 
FILE HASH
|
PRIMARY AREA
|
├─ BUCKET 0 [Blocco 1, Header: num_records=2, overflow_ptr = O1]
|  ├─ Record: 12
|  └─ Record: 20
|
├─ BUCKET 1 [Blocco 2, Header: num_records=0, overflow_ptr = null]
|
├─ BUCKET 2 [Blocco 3, Header: num_records=0, overflow_ptr = null]
|
├─ BUCKET 3 [Blocco 4, Header: num_records=0, overflow_ptr = null]
|
OVERFLOW AREA
|
├─ O1 [Blocco 5, Header: num_records=2, next = O2]
|  ├─ Record: 28
|  └─ Record: 36
|
└─ O2 [Blocco 6, Header: num_records=1, next = null]
   └─ Record: 44
```

---