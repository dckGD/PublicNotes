In RISC-V, i **CSR (Control and Status Registers)** sono registri speciali **interni alla [[CPU]]**, usati per: controllare il comportamento del processore (status, interrupt, ecc.), gestire il passaggio tra modalità di privilegio (U/S/M), **osservare o configurare** lo stato della CPU.

___
### CLASSIFICAZIONE PER FUNZIONE

|Categoria|Descrizione|Esempi principali|
|---|---|---|
|**Status Registers**|Stato generale della CPU e privilegi|`mstatus`, `sstatus`, `ustatus`|
|**Trap Handling**|Gestione di trap e ritorni|`mepc`, `sepc`, `mcause`, `scause`, `stvec`, `mtvec`, `mret`, `sret`|
|**Interrupt Control**|Abilitazione e gestione interrupt|`mie`, `mip`, `sie`, `sip`|
|**Exception Info**|Diagnostica di eccezioni|`mtval`, `stval`|
|**Memory/VM Config**|Configurazione della memoria virtuale|`satp`, `medeleg`, `medeleg`|
|**Timer & Performance**|Timer, contatori e benchmarking|`cycle`, `time`, `instret`, `mtimecmp`|
|**Debug & Misc**|Debug, identificazione core, versioni|`dcsr`, `mhartid`, `mvendorid`|

---
### CLASSIFICAZIONE PER PRIVILEGIO

|Livello|Chi può accedere|CSR tipici|
|---|---|---|
|**M-mode**|Solo firmware/hypervisor|`mstatus`, `mepc`, `mcause`, `mtvec`, `mie`, `mip`, `misa`, `mhartid`, `satp`|
|**S-mode**|OS Kernel|`sstatus`, `sepc`, `scause`, `stvec`, `sie`, `sip`, `stval`, `satp`|
|**U-mode**|Programmi utente|Solo CSR limitati (se supportati), es. `ustatus`, `cycle`|

---
### TRAP/EXCEPTION HANDLING

| CSR      | Modalità | Contenuto                                 | Scopo principale                            |
| -------- | -------- | ----------------------------------------- | ------------------------------------------- |
| `mepc`   | M        | PC al momento della trap                  | Ripresa esecuzione (`mret`)                 |
| `mcause` | M        | Codice della causa della trap             | Identificare tipo di trap (eccezione o int) |
| `mtvec`  | M        | Indirizzo di routine trap (direct/vect)   | Salto al gestore trap                       |
| `mtval`  | M        | Valore legato alla trap (indirizzo/istr.) | Diagnostica                                 |
| `sepc`   | S        | PC dell’istruzione che ha causato la trap | Ripresa esecuzione (`sret`)                 |
| `scause` | S        | Codice della causa della trap             | Identificazione e routing                   |
| `stvec`  | S        | Routine trap per trap gestite in S-mode   | Salto gestore kernel                        |
| `stval`  | S        | Valore legato alla trap                   | Diagnostica                                 |

---
### SOTTOSISTEMA INTERRUPT

| CSR   | Descrizione                      | Modalità |
| ----- | -------------------------------- | -------- |
| `mie` | Abilitazione interrupt in M-mode | M        |
| `mip` | Interrupt pendenti in M-mode     | M        |
| `sie` | Abilitazione interrupt in S-mode | S        |
| `sip` | Interrupt pendenti in S-mode     | S        |

---
### MEMORIA E VIRTUALIZZAZIONE

|CSR|Descrizione|Modalità|
|---|---|---|
|`satp`|Paginazione e configurazione memoria virtuale|S (o M)|
|`medeleg`|Delegazione eccezioni da M a S|M|
|`mideleg`|Delegazione interrupt da M a S|M|

---
### CONTATORI TEMPORALI E PERFORMANCE

|CSR|Descrizione|Modalità|
|---|---|---|
|`cycle`|Conta i cicli della CPU|Tutte*|
|`time`|Timer (può essere delegato da M)|Tutte*|
|`instret`|Conta le istruzioni ritirate|Tutte*|
|`mtime`, `mtimecmp`|Timer per interrupt temporizzati|M|

---
### ISTRUZIONI PER ACCESSO AI CSR

| Istruzione      | Effetto                   |
| --------------- | ------------------------- |
| `csrr rd, csr`  | Legge il CSR              |
| `csrw csr, rs1` | Scrive nel CSR            |
| `csrrw`         | Legge e scrive (scambia)  |
| `csrs`, `csrc`  | Set / clear bit specifici |

---