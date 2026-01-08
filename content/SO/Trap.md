**Una trap di sistema** è qualsiasi evento che provoca il passaggio dell’esecuzione da **[[Privilege Levels#User mode|user mode]]** a **[[Privilege Levels#Kernel mode|kernel mode]]**, consentendo al sistema operativo di riprendere il controllo. In particolare, si distinguono tre tipi di trap:

---
### SYSTEM CALL

Richiesta esplicita di un servizio del sistema operativo. Sono **sincrone** e **innescate dal software** (dal programma utente). Ecco come viene gestita una system call:

---
#### 1. Programma utente

L’utente chiama nel suo programma (user mode) una funzione API, per svolgere delle istruzioni privilegiate (eseguibili solo in kernel mode):

```c
write(fd, buf, 10);
```

Nell'esempio l'utente vuole scrivere 10 byte su un file o dispositivo (istruzione privilegiata).

---
#### 2. Funzione API

Quando il programma viene **compilato** e **linkato**, la chiamata `write()` viene collegata alla **libreria API del sistema operativo**. Questa funzione contiene **istruzioni macchina concrete** che preparano la system call. L'API prepara parametri, inserisce il numero della syscall e provoca la trap con l’istruzione `syscall`.   

Istruzioni in codice macchina nella funzione API corrispondente a alla chiamata dell'esempio:

```assembly
mov rax, SYS_write   ; numero identificativo della syscall
mov rdi, fd          ; primo parametro
mov rsi, buf         ; secondo parametro
mov rdx, 10          ; terzo parametro
syscall              ; istruzione di trap
```

---
#### 3. CPU legge la trap

Quando la CPU esegue l’istruzione `syscall`:

- Riconosce una **trap software sincrona**.
- Salva il contesto del processo (registri, program counter).
- Passa da **user mode → kernel mode**.
- Determina il numero della trap (tipo trap: system call).

---
#### 4. Interrupt Vector Table (IVT)

La IVT è una **tabella in memoria kernel** che associa ogni tipo di trap a una specifica **routine kernel** per quel tipo di trap. 

```r
trap syscall → System Call Handler
```

Nel nostro esempio la CPU prende il tipo di trap (`syscall`) come indice nella tabella e legge l’indirizzo del **System Call Handler** (routine kernel valida per tutte le system call).

---
#### 5. System Call Handler

Il **System Call Handler** è una routine kernel che **gestisce tutte le system call**:

- Legge il **numero della system call** che l’API ha messo in `rax` (ad esempio `SYS_write`).
- Consulta la **System Call Table** per trovare la funzione kernel corrispondente (`sys_write`).
- Chiama la funzione kernel.

---
#### 6. System Call Table

La **System Call Table** è una tabella interna al kernel utilizzata dal System Call Handler per mappare il numero della system call chiamata alla rispettiva funzione kernel di gestione:

```r
0 → sys_read
1 → sys_write
2 → sys_open
...
```

Nel nostro esempio, la CPU/handler legge il numero della syscall (`1` per write) e trova il puntatore a `sys_write`(funzione kernel corrispondente).

---
#### 7. Funzione kernel 

Ora la funzione kernel (`sys_write`) esegue il servizio reale (azioni privilegiate). 

Nel nostro caso: 

- scrive 10 byte sul file o dispositivo
- aggiorna strutture dati del kernel (buffer, file descriptor table)
- gestisce permessi, sincronizzazione, driver hardware.

---
#### 8. Ritorno in user mode

Quando `sys_write` termina:

- Il System Call Handler finisce.
- La CPU ripristina il contesto salvato prima della trap (registri, PC).
- La CPU torna in **user mode**, riprendendo l’esecuzione subito dopo la chiamata `write()`.
- Il valore di ritorno della syscall (numero di byte scritti) viene passato all’API e quindi al programma utente.

---
### EXCEPTION

Gestione di errori o condizioni anomale (es. divisione per zero, accesso a memoria non valida). Sono **sincrone** e **innescate dal software** come conseguenza dell’istruzione eseguita.

---
### INTERRUPT

Segnalano il verificarsi di un evento esterno (es. completamento di I/O, timer). Sono **asincroni** e **innescati dall’hardware**.

---
#### Interrupt asincroni e timer hardware

Oltre alle trap sincrone, durante l’esecuzione di un programma possono verificarsi **interrupt asincroni**, generati dall’hardware. Il più importante è l’**interrupt del timer**.

Il **timer hardware** è un componente della CPU o del sistema che genera interrupt a intervalli regolari. Il suo scopo è impedire che un processo monopolizzi la CPU e permettere la **multiprogrammazione**.

Quando scatta un interrupt del timer:

- la CPU interrompe il processo in esecuzione
- salva il suo contesto
- entra in kernel mode
- esegue la routine kernel associata al timer

Questo interrupt dà al kernel la possibilità di avviare lo **scheduler**.

---
#### Scheduler e gestione dei processi

Lo **scheduler** è una componente del kernel che decide **quale processo deve usare la CPU**. I processi sono organizzati in base al loro stato:

- **running**: processo attualmente in esecuzione sulla CPU
- **ready**: processi pronti a essere eseguiti, in attesa nella **coda dei processi pronti**
- **waiting/blocked**: processi in attesa di un evento (I/O, system call, segnale)

Durante un interrupt del timer, lo scheduler può decidere:

- di continuare a eseguire lo stesso processo
- oppure di sospenderlo e selezionare un altro processo dalla coda dei pronti

Il cambio di processo avviene tramite **context switch**, in cui il kernel salva il contesto del processo uscente e ripristina quello del processo entrante.

> N.B. Non è detto che **ogni interrupt del timer** produca un cambio di processo, ma ogni interrupt rende possibile lo scheduling.

---
#### Relazione tra trap sincrone e interrupt asincroni

Trap sincrone e interrupt asincroni condividono lo stesso meccanismo di base:

- salvataggio del contesto
- passaggio a kernel mode
- esecuzione di una routine kernel
- ritorno in user mode

La differenza principale è che:

- le **trap sincrone** sono causate dal processo stesso e devono essere gestite immediatamente
- gli **interrupt asincroni** arrivano dall’hardware e possono avvenire in qualsiasi momento

Durante l’esecuzione di codice kernel, il sistema operativo può temporaneamente disabilitare o ritardare interrupt meno prioritari per evitare interferenze.

---
#### Atomicità e sincronizzazione

Poiché interrupt e trap possono verificarsi in qualunque momento, il kernel deve garantire che alcune operazioni critiche non vengano interrotte.

Una sequenza di istruzioni è detta **atomica** se viene eseguita completamente senza possibilità di interruzione. L’atomicità è fondamentale per proteggere dati condivisi del kernel.

La **sincronizzazione** è l’insieme di tecniche che permettono a più processi o routine kernel di cooperare correttamente, evitando condizioni di gara. Il kernel utilizza meccanismi come:

- istruzioni atomiche fornite dall’hardware
- lock e mutex
- semafori

Grazie a questi meccanismi, il sistema operativo può gestire correttamente trap sincrone, interrupt asincroni e concorrenza tra processi.

---
#### Ritorno in user mode

Quando la routine kernel termina:

- il kernel decide quale processo deve riprendere l’esecuzione (scheduler)
- la CPU ripristina il contesto del processo scelto
- la CPU torna in **user mode**

L’esecuzione del programma continua dal punto in cui era stata interrotta, **oppure** dal processo selezionato dallo scheduler.

---