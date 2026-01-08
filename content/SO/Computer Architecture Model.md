Il **modello di un'architettura di un calcolatore** descrive la **struttura logica e funzionale** di un sistema di calcolo, ovvero **come sono organizzati i componenti principali** e **come interagiscono tra loro**. Non riguarda l’implementazione elettronica di dettaglio, ma fornisce un **modello astratto** utile per comprendere il funzionamento del computer, progettare software efficiente e studiare i [[Operating System|sistemi operativi]].

---
### VON NEUMANN
![[von neumann architecture.png]]**Caratteristiche**

- Un’unica **memoria** per dati e istruzioni
- **CPU** composta da unità di controllo e ALU
- **Bus condivisi** per dati e istruzioni

> N.B. Questo modello, concettualmente molto semplice, ha un limite che possiamo identificare con il fenomeno chiamato **collo di bottiglia di Von Neumann**: dati e istruzioni condividono la stessa memoria e lo stesso unico bus dunque la CPU non può leggere/scrivere istruzioni e dati simultaneamente e gli accessi in memoria sono seriali (assenza di parallelismo).

---

Il **modello di Von Neumann** è un modello storico e concettualmente semplice, su cui si basano **tutte le architetture moderne**, perché definisce la logica fondamentale di CPU, memoria e I/O. Tuttavia, le CPU moderne **modificano e ottimizzano questo modello** per migliorare le prestazioni:

- utilizzano **cache separate per dati e istruzioni**
- implementano **pipeline e parallelismo**
- introducono **esecuzione fuori ordine (out-of-order)** e altre ottimizzazioni per ridurre il collo di bottiglia di Von Neumann.

---
### COMPONENTI

Un **modello di architettura di un calcolatore** descrive la struttura logica del sistema e generalmente comprende i seguenti componenti principali:

- [[CPU]]
- [[BD/Physical Layer/Memory Hierarchy|Memoria]]
- [[System Bus]]
- [[IO Devices|Dispositivi I/O]]

---