La componente di **Input/Output (I/O)** consente al calcolatore di **interagire con il mondo esterno**, permettendo lo scambio di dati tra CPU, memoria e dispositivi periferici. La gestione dell’I/O è complessa perché coinvolge sia **hardware** sia **software**, ed è affidata in gran parte al **[[Operating System|sistema operativo]]**, in particolare al **kernel**.

---
### COMPONENTI
![[io system.png]]
#### Dispositivo fisico e device controller

Il **dispositivo fisico** è la periferica vera e propria (ad esempio tastiera, disco, stampante, interfaccia di rete). Questo dispositivo **non comunica direttamente con la CPU**, ma è gestito da un **device controller**, un componente hardware che funge da intermediario.

Il **device controller** controlla il funzionamento del dispositivo fisico e traduce i comandi generici ricevuti dalla CPU in segnali elettrici comprensibili dal device, e viceversa. Ogni controller è collegato al **bus di sistema** ed espone una serie di **registri** attraverso i quali è possibile comunicare con esso.

---
##### Registri del controller

I controller mettono a disposizione della CPU alcuni **registri dedicati**, che rappresentano l’interfaccia hardware del dispositivo. Questi registri sono tipicamente suddivisi in:

- **Registri di stato**, che indicano la condizione del dispositivo (pronto, occupato, errore, dati disponibili, ecc.)
- **Registri di controllo o configurazione**, utilizzati per impartire comandi e impostare modalità operative
- **Registri di dati**, che contengono i dati trasferiti tra dispositivo e sistema

La CPU non accede mai direttamente al dispositivo fisico, ma **solo a questi registri**.

---
#### Device driver e kernel

Il **device driver** è un componente software del **sistema operativo** che permette di controllare un dispositivo senza che i programmi applicativi ne conoscano i dettagli hardware. Il driver conosce:

- la struttura dei registri del controller
- il significato dei bit di controllo e di stato
- le sequenze corrette di operazioni per effettuare l’I/O

Il driver opera in **modalità kernel**, perché deve avere accesso diretto all’hardware. Il **kernel** è il nucleo del sistema operativo e si occupa della gestione delle risorse fondamentali del sistema, tra cui processi, memoria e dispositivi di I/O. Il sottosistema I/O del kernel coordina l’uso dei driver e fornisce un’interfaccia uniforme ai programmi.

---
### INDIRIZZAMENTO DEI DISPOSITIVI I/O

Per poter comunicare con i dispositivi di I/O, la CPU deve indirizzare i registri dei **device controller** attraverso il **[[System Bus|bus di sistema]]**. L’accesso ai dispositivi non avviene quindi direttamente sul device fisico, ma tramite i registri esposti dal controller, che sono visibili alla CPU come destinazioni di lettura e scrittura. Esistono **due modelli architetturali principali** che definiscono **come questi registri vengono indirizzati**.

---
#### Memory-mapped I/O

Nel **memory-mapped I/O**, i registri dei device controller sono **mappati nello spazio di indirizzamento della memoria principale**. Ciò significa che alcuni intervalli di indirizzi, pur avendo la forma di indirizzi di memoria, non corrispondono a celle di RAM ma a registri di dispositivi.

In questo modello:

- memoria e I/O condividono **lo stesso spazio di indirizzamento**
- la CPU utilizza **normali istruzioni di load/store**
- la distinzione tra RAM e I/O avviene tramite **decodifica dell’indirizzo**

Dal punto di vista della CPU, l’accesso a un registro I/O è indistinguibile da un accesso a una locazione di memoria; è l’hardware di decodifica a stabilire se l’indirizzo seleziona la RAM o un controller. Questo modello è oggi **il più diffuso**, soprattutto nelle architetture RISC.

---
#### Port-mapped I/O

Nel **port-mapped I/O**, i registri dei controller non fanno parte dello spazio di indirizzamento della memoria, ma sono collocati in uno **spazio di indirizzi separato**, detto **spazio delle porte di I/O**.

In questo modello:

- memoria e I/O hanno **spazi di indirizzamento distinti**
- la CPU utilizza **istruzioni specifiche di I/O**
- il **bus di controllo** segnala che l’operazione riguarda l’I/O tramite una linea M/IO (se M/IO = 0 allora l'operazione riguarda l'I/O, se M/IO = 1 allora l'operazione riguarda la RAM)

Il valore posto sul bus degli indirizzi viene interpretato come **numero di porta**, non come indirizzo di memoria. Questo modello è tipico di alcune ISA storiche, come x86.

---
### TASK DI I/O 

Le **task di I/O** descrivono **come viene gestita operativamente una richiesta di input/output**, ovvero **come la CPU viene informata dell’avanzamento e del completamento di un’operazione I/O** e **chi si occupa del trasferimento dei dati**.

La gestione dell’I/O può avvenire secondo **diverse modalità**, che differiscono per:

- coinvolgimento della CPU
- efficienza
- complessità hardware e software

---
#### Polling

Nel **polling**, la CPU controlla attivamente lo stato del dispositivo interrogando ripetutamente il **registro di stato** del controller.

1. la CPU (tramite il driver) avvia l’operazione di I/O
2. entra in un ciclo di controllo (busy waiting)
3. legge periodicamente il registro di stato
4. quando il dispositivo segnala “pronto”, procede al trasferimento dei dati

---
#### interrupt-driven

Nella gestione **interrupt-driven**, la CPU non controlla continuamente il dispositivo, ma viene **notificata tramite un interrupt** quando l’operazione di I/O è completata o richiede attenzione.

1. la CPU avvia l’operazione di I/O
2. prosegue l’esecuzione di altri programmi
3. il controller genera un **interrupt**
4. la CPU: sospende temporaneamente il programma corrente, esegue la **routine di servizio dell’interrupt** (ISR) e infine riprende l’esecuzione normale

---
#### Trasferimento dei dati: CPU vs DMA

Le modalità di gestione precedenti definiscono **come viene segnalato l’I/O**, ma non **chi trasferisce i dati**. Il trasferimento può avvenire in due modi:

---
##### I/O programmato (CPU-controlled I/O)

Nel trasferimento controllato dalla CPU:

- la CPU legge e scrive direttamente i **registri di dati** del controller
- ogni parola di dati passa attraverso la CPU

Questo modello può essere usato sia con **polling** che con **interrupt**.

---
##### Direct Memory Access (DMA)

Nel **DMA**, il trasferimento dei dati avviene **direttamente tra dispositivo e memoria**, senza coinvolgere la CPU per ogni singola operazione:

1. la CPU configura il **DMA controller** (indirizzo, dimensione, direzione)
2. avvia l’operazione
3. il DMA controller gestisce il trasferimento
4. al termine, viene generato un **interrupt**  

Questo modello può essere usato con **interrupt**.

---
