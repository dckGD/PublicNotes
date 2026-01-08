Un **structural hazard** (hazard strutturale) si verifica quando **due o più istruzioni vogliono usare la stessa risorsa hardware nello stesso ciclo di clock**, ma **l’architettura non è in grado di gestirle contemporaneamente**.

---

**Esempi di risorse in conflitto**:

- **1 sola memoria** condivisa tra istruzioni e dati (memoria unificata). (es. `lw` e `sw` in casi particolari)
- **1 sola ALU**, ma più istruzioni che vorrebbero eseguire operazioni aritmetiche.
- **1 solo bus** per leggere/scrivere, ma più istruzioni lo richiedono insieme.

**RISC-V per design evita gli structural hazard**, lasciando all’implementazione hardware la libertà di usare risorse separate.

---