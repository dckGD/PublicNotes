La memoria virtuale è un'astrazione sopra la memoria fisica ([[RAM]]) e permette al [[Operating System|sistema operativo]] di gestire l'allocazione e l'accesso alla memoria in modo molto più flessibile ed efficiente durante l'esecuzione di un [[Process|processo]]. Tale astrazione viene mappata (**[[Physical-Virtual Mapping|mapping]]**) alla memoria fisica da parte del sistema operativo, che utilizza la **[[CPU Units#MMU (Memory Management Unit)|MMU]] (Memory Management Unit)** per gestire la traduzione degli indirizzi virtuali in indirizzi fisici.

---
### ORGANIZZAZIONE

Ecco come è organizzata una memoria virtuale:

```d
// Indirizzo alto  (0xFFFFFFFF in 32-bit)
----------------------
| Kernel Space       |  (Memoria riservata al kernel)
----------------------       
| Stack Utente (↓)   |      
----------------------  
| Spazio Libero      |  
----------------------
| Heap Utente (↑)    |  
----------------------
| .bss (uninit data) |
----------------------
| .data (init data)  |
----------------------
| .text (codice)     |  
----------------------
| Riservato / NULL   |  (Indirizzi bassi spesso non validi)
----------------------
// Indirizzo basso  (0x00000000)
```

---
#### KERNEL SPACE

**Posizione**: Kernel Space.
**Descrizione**: Questa zona è **riservata al kernel** del sistema operativo, che è il cuore del sistema e gestisce tutte le risorse hardware. Il kernel ha **accesso completo** alla memoria del sistema e può manipolarla liberamente. A questa parte di memoria non può accedere direttamente un processo in esecuzione (programma utente).

---
#### STACK UTENTE (↓):

**Posizione**: User Space.
**Descrizione**: Lo **stack** è una struttura dati usata dai programmi per memorizzare variabili locali, indirizzi di ritorno da funzioni e informazioni relative all'esecuzione delle funzioni. Lo stack cresce **verso il basso**, ossia dalla fine dell'area di memoria verso l'indirizzo basso. Ogni volta che una funzione viene chiamata, viene aggiunto un nuovo **frame** allo stack. 

---
#### SPAZIO LIBERO:

**Posizione**: User Space.
**Descrizione**: Questa zona è semplicemente "non utilizzata" e può essere occupata per vari scopi, a seconda del sistema operativo e dell'applicazione. Serve soprattutto a non far collidere heap e stack, che crescono sopra questo spazio.

---
#### HEAP UTENTE (↑):

**Posizione**: User Space.
**Descrizione**: L'**heap** è un'area di memoria utilizzata per **l'allocazione dinamica**. Qui vengono allocate dinamicamente le variabili, cioè quelle variabili la cui dimensione e durata sono determinate in fase di esecuzione. Quando un processo richiede una nuova porzione di memoria durante l'esecuzione, questa memoria viene allocata dall'heap. A differenza dello stack, l'heap cresce **verso l'alto**, ossia dall'indirizzo basso verso l'indirizzo alto.

---
#### .bss (UNINITIALIZED DATA):

**Posizione**: User Space.
**Descrizione**: La sezione **.bss** contiene **variabili globali non inizializzate**. Quando il processo viene eseguito, il sistema operativo assegna a queste variabili un valore di default, che solitamente è zero.

---
#### .data (INITIALIZED DATA):

**Posizione**: User Space.
**Descrizione**: La sezione **.data** contiene **variabili globali e statiche inizializzate** (ovvero variabili che hanno un valore definito all'inizio del programma). Per esempio, un array dichiarato come `int arr[] = {1, 2, 3};` finirà in questa sezione.

---
#### .text (CODICE):

**Posizione**: User Space.
**Descrizione**: La sezione **.text** contiene il **codice eseguibile** del programma (le istruzioni del programma stesso). È la parte che il processore esegue. Le istruzioni contenute in `.text` sono generalmente **solamente in lettura** per evitare modifiche accidentali da parte del processo in esecuzione.

---
#### RISERVATO / NULL:

**Posizione**: La parte più bassa della memoria.
**Descrizione**: Gli indirizzi bassi spesso sono **non validi** o **riservati** per l'uso del sistema operativo, e a volte sono utilizzati per **valori nulli** o per **il controllo degli errori**. Questi indirizzi non vengono mai utilizzati da un programma utente, e l'accesso a questa zona è generalmente **proibito**.

---