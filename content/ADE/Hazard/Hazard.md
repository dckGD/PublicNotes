Gli **hazard** (criticità) sono situazioni in cui il flusso regolare della pipeline viene **interrotto o alterato**, causando **ritardi** o comportamenti errati. Esistono tre tipi principali:

| Tipo di hazard                        | Causa                                                        | Effetto                                     |
| ------------------------------------- | ------------------------------------------------------------ | ------------------------------------------- |
| **[[Data Hazard\|Data]]**             | Una istruzione ha bisogno di un dato che non è ancora pronto | Dipendenza tra registri                     |
| **[[Control Hazard\|Control]] **      | Una decisione di salto (branch) non è ancora risolta         | Si rischia di eseguire istruzioni sbagliate |
| **[[Structural Hazard\|Structural]]** | Due istruzioni competono per la stessa risorsa hardware      | Conflitto su bus, ALU o memoria             |

---
**IF                                         ID                         EX                     MEM                   WB
![[Pasted image 20250616144107.png]]

---