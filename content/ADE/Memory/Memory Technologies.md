Le tecnologie di memoria si differenziano per velocità, costo, consumi, capacità e volatilità. Ogni tipo è utilizzato in uno specifico livello della gerarchia della memoria, a seconda delle esigenze del sistema: prestazioni, costo o persistenza dei dati.

---
### SRAM (STATIC RANDOM ACCESS MEMORY)

#### Caratteristiche

- **Volatile**: i dati si perdono senza alimentazione
- **Alta velocità**: accesso molto rapido
- **Nessun refresh**: mantiene i dati finché alimentata
- **Costosa**: elevato costo per bit
- **Consumo energetico elevato** 

---
#### Uso tipico

Utilizzata per **cache di livello L1, L2, L3** e nei **registri interni a microcontrollori** embedded.

---
#### Funzionamento

Ogni bit è immagazzinato usando un **flip-flop** (tipicamente 6 transistor), che mantiene stabile il valore logico (0 o 1) senza necessità di aggiornamenti periodici.

---
### DRAM (DYNAMIC RANDOM ACCESS MEMORY)

#### Caratteristiche

- **Volatile**
- **Media velocità**
- **Necessita di refresh periodico**
- **Alta densità**: più bit per chip rispetto alla SRAM
- **Più economica** della SRAM 

---
#### Uso tipico

Usata come **memoria principale (RAM)** nei computer e come Interfacciata tramite bus di memoria ad alta larghezza di banda (es. DDR4, DDR5)

---
#### Funzionamento

Ogni bit è rappresentato da un **condensatore + transistor**:
Il condensatore trattiene la carica (0 o 1) per un tempo limitato
È necessario rinfrescare i dati costantemente (~ogni 64 ms)

---
### FLASH (SSD)

#### Caratteristiche

- **Non volatile**: i dati restano anche senza alimentazione
- **Velocità intermedia** tra DRAM e disco
- **Accesso a blocchi**, non byte a byte
- **Cancellazione limitata**: numero finito di cicli di scrittura
- **Nessun refresh necessario** 

---
#### Uso tipico

**SSD (Solid State Drive)**
**Firmware** (BIOS, bootloader)
**Schede SD, USB flash drive**

---
#### Funzionamento

I bit sono memorizzati tramite cariche elettriche intrappolate in un **gate flottante** all’interno di un transistor MOSFET modificato.

---
### MEMORIA A DISCO (HDD)

#### Caratteristiche

- **Non volatile**
- **Molto lenta**: tempi di accesso nell'ordine dei millisecondi
- **Economica**
- **Elevatissima capacità**
- **Parte meccanica**: piatti rotanti e testine mobili 

---
#### Uso tipico

**Memoria di massa** per sistemi desktop/server
Archiviazione di **dati freddi** (accesso infrequente)

---
#### Funzionamento

##### Elementi meccanici:

![[hard disk 1.png]]**Piatti (platters):** dischi rigidi rivestiti di materiale magnetico montati sullo stesso asse che ruotano **tutti insieme**.

**Motore di rotazione (spindle motor):** motore dell'asse che fa ruotare tutti i dischi uniformemente a velocità costante (es. 5.400, 7.200, 10.000 RPM)

**Braccio attuatore (actuator arm):** struttura meccanica mobile che sposta radialmente le testine sul disco.

**Attuatore a bobina (voice coil actuator):** sistema elettromagnetico che muove i bracci tutti insieme (il movimento dei bracci non è indipendente) con estrema precisione.

**Testine di lettura/scrittura:** dispositivi elettromagnetici microscopici, montati all’estremità del braccio attuatore, che **leggono e scrivono i dati** magnetizzando o rilevando la magnetizzazione della superficie dei dischi, senza contatto fisico diretto (distanza di pochi nanometri).

---
##### Composizione di un platter:

![[hard disk.png]]

**Superficie magnetica:** ogni piatto ha **due superfici** (superiore e inferiore) e ogni superficie è divisa logicamente in:

- **Tracce (tracks):** cerchi concentrici a un raggio fisso dal centro.
- **Settori (sectors):** suddivisioni angolari delle tracce e unità minime di lettura/scrittura (tipicamente 512 B o 4 KB).
- **Cilindri:** le tracce con **stesso raggio** su superfici diverse formano un **cilindro**, per spostarsi tra tracce dello stesso cilindro basta selezionare una testina diversa (non richiede **seek**), infatti come abbiamo detto le testine si muovono tutte insieme.

---
##### Posizionamento del dato:

Il tempo di lettura/scrittura di un dato è dato da 3 azioni:

- **Seek time:** il braccio si muove fino al cilindro corretto
- **Rotational latency:** attesa che il settore desiderato passi sotto la testina
- **Transfer time:** lettura/scrittura effettiva del dato

---

