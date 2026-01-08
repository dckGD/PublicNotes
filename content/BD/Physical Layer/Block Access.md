Nella gestione dei dati su disco, il [[DBMS|DBMS]] non opera direttamente sui singoli record, ma su **blocchi di dati**, unità fondamentali di trasferimento tra **memoria secondaria** e **memoria principale**. L’organizzazione fisica dei blocchi e le modalità di accesso incidono direttamente sulle **prestazioni del sistema**, determinando i tempi di lettura e scrittura e influenzando l’efficienza complessiva delle operazioni di I/O.

> N.B. Nei DBMS una pagina corrisponde fisicamente a un blocco di disco; i termini sono usati in modo equivalente a seconda del livello di astrazione.

---
### TEMPO DI RISPOSTA

**Response time = Service time + Queueing time**

È il **tempo totale** che intercorre tra la richiesta di I/O e il completamento dell’operazione (tempo di accesso a un blocco).

---
#### Queueing time:  

Tempo di attesa nella coda delle richieste di I/O, dovuto a richieste concorrenti. Dipende dal carico del sistema.

---
#### Service time

È il tempo necessario al disco per **servire effettivamente** una richiesta. Dipende **dalla struttura fisica e dalla tecnologia del dispositivo**. Nel caso di **HDD**:

**Service time = Seek time + Rotational delay + Transfer time**

Guarda il [[Memory Technologies#MEMORIA A DISCO (HDD)|funzionamento di un hard disk]]

- **Seek time**: tempo per posizionare le testine sulla traccia corretta
- **Rotational delay**: tempo di attesa affinché il settore richiesto passi sotto la testina
- **Transfer time**: tempo necessario per leggere o scrivere i dati una volta che il settore è sotto la testina

---
### TIPOLOGIE DI ACCESSO

Nel caso di **HDD** le tipologie di accesso a un blocco sono due, e anche da queste dipende il [[Block Access#Service time|service time]] finale.

> Elementi utili e abbreviazioni:
> **Block size (BS):** dimensione del blocco di dati (es. 4096 bytes ≈ 4 Kb).
> **Seek time (SK):** tempo necessario a spostare il braccio attuatore dell’hard disk fino alla traccia corretta (es. 8.9 ms).
> **Rotation time (ROT):** tempo necessario al disco per compiere **una rotazione completa** dei piatti. Determina il ritardo di rotazione; in media, l’attesa per un settore è pari a **ROT/2** (mezzo giro).
> **Transfer rate (TR):** velocità con cui i dati vengono trasferiti tra il disco e la memoria. Dipende dalla densità dei dati sul disco e dalla velocità di rotazione. (es. 150 MBps).

---
#### Random Block Access (RBA)

Il blocco è **indipendente** da quello precedente (serve riposizionare la testina).

**Costo di servizio:**

$$T_{rba} = SK + \frac{ROT}{2} + \frac{BS}{TR}$$

---
#### Sequential Block Access (SBA)

Il blocco è **contiguo** al precedente e la testina è già posizionata correttamente (si continua a leggere lungo la traccia precedente). Dunque non serve calcolare il tempo di seek.

**Costo di servizio:**

$$T_{sba} = \frac{ROT}{2} + \frac{BS}{TR}$$

---


