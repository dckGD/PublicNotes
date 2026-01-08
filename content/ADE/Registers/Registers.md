In un'[[ISA]], un **registro** è una piccola area di memoria **veloce** che il processore usa per **memorizzare e manipolare dati**. I registri sono componenti cruciali della [[CPU]] e vengono usati per eseguire calcoli, memorizzare indirizzi e passare informazioni tra le diverse parti del processore. I registri sono **fisicamente** realizzati come piccole celle di memoria **integrate** direttamente nel chip del processore, che le rende **molto più veloci** rispetto alla memoria principale. L'architettura [[RISC-V]], come ogni ISA, ha il suo set di [[General Registers in RISC-V|registri generali]].

---
### FUNZIONI DEI REGISTRI

**Memorizzazione Temporanea dei Dati**: 

I registri memorizzano valori temporanei durante l'esecuzione di calcoli o operazioni logiche.  Ad esempio, un registro può contenere un valore da sommare o un risultato intermedio.    

---

**Passaggio di Parametri e Risultati:**

I registri vengono utilizzati per passare dati tra funzioni e per ritornare valori da una funzione a un'altra.

---

**Gestione degli Indirizzi:**  

In molti casi, i registri memorizzano indirizzi di memoria per accedere a dati o istruzioni nella memoria principale.

---

**Controllo del Flusso di Esecuzione:**  

Alcuni registri, come il Program Counter (PC), sono utilizzati per gestire il flusso di esecuzione delle istruzioni.

---