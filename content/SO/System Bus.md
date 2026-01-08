Un **bus** è un **canale di comunicazione condiviso** che permette lo scambio di dati, indirizzi e segnali di controllo tra i componenti di un calcolatore (CPU, memoria, I/O). È uno degli elementi fondamentali di un [[Computer Architecture Model|modello di architettura]], perché coordina le operazioni e trasferisce informazioni tra i diversi dispositivi.

---
### TIPOLOGIE
![[system bus.png]]
#### Bus dati

Il **bus dati** è il canale attraverso cui viaggiano i dati veri e propri tra CPU, memoria e periferiche. La sua larghezza, espressa in bit, determina quanti dati possono essere trasferiti in un singolo ciclo di comunicazione: un bus a 8, 16, 32 o 64 bit permette quindi di spostare quantità crescenti di informazioni per ogni operazione. In pratica, più è ampio il bus, maggiore è la quantità di dati che il sistema può elaborare simultaneamente.

---
#### Bus indirizzi

Il **bus indirizzi** trasporta gli indirizzi di memoria o di I/O che indicano alla CPU dove leggere o scrivere i dati. La sua larghezza definisce lo **spazio di indirizzamento massimo** che il sistema può raggiungere: ad esempio, un bus indirizzi a 32 bit consente di indirizzare fino a 4 GB di memoria. È quindi il bus che permette alla CPU di “puntare” alla posizione corretta all’interno della memoria.

---
#### Bus di controllo

Il **bus di controllo** trasmette tutti i segnali necessari a coordinare e sincronizzare le operazioni del sistema. Attraverso questo bus viaggiano comandi come lettura o scrittura, segnali di selezione dei dispositivi, notifiche di interrupt e impulsi di clock. È il canale che assicura che ogni componente sappia _quando_ e _come_ deve agire, mantenendo l’intero sistema in perfetta coordinazione.

---
### INDIRIZZAMENTO
![[system bus addressing.png]]
L’**indirizzamento** è il meccanismo attraverso cui la CPU seleziona **quale componente del sistema deve partecipare a un’operazione di lettura o scrittura**. Questo processo avviene sempre tramite il **bus di sistema**.

Durante un’operazione di accesso, la CPU:

- pone un valore sul **bus degli indirizzi**
- specifica il tipo di operazione sul **bus di controllo** (lettura o scrittura)
- scambia i dati tramite il **bus dei dati**

---
#### Esempio:
![[system bus addressing 1.png]]
In questo caso la CPU sta accedendo ad un indirizzo di memoria:

- invia l'indirizzo 0000 sul bus degli indirizzi
- invia il segnale READ sul bus di controllo
- riceve il dato 001110 (corrispondente all'indirizzo 0000) dalla RAM, sul bus dei dati

> Leggi [[IO Devices#INDIRIZZAMENTO DEI DISPOSITIVI I/O|qui]] per l'estensione sull'indirizzamento dei dispositivi di I/O.

---
