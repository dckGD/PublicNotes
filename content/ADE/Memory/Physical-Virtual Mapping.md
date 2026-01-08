Vediamo come avviene la mappatura tra memoria fisica e [[Virtual Memory|virtuale]].

---
### INDIRIZZI VIRTUALI

Quando un programma gira su un sistema operativo moderno, **non lavora con indirizzi fisici ([[RAM]])**, ma con **indirizzi virtuali**. Questa è un’astrazione gestita dal sistema operativo per:

- isolare i processi (ogni programma sembra avere tutta la memoria per sé)
- proteggere la memoria
- semplificare la gestione

Un **indirizzo virtuale** è quello che un programma “crede” di usare.  
Un **indirizzo fisico** è dove si trovano davvero i dati in RAM.

> Esempio: il programma accede a `0x00001234` (virtuale), ma il dato sta fisicamente a `0x87A91234` in RAM.

---
### PAGES E FRAME

La memoria **virtuale e fisica** è divisa in **pagine** (virtuali) e **frame** (fisici), cioè **[[Block|blocchi]] di dimensione fissa** (es. 4 KB).

- Le **pagine virtuali** sono i blocchi numerati nella memoria "vista" dal processo (miss di memoria virtuale = **page fault**).
- I **frame fisici** sono le caselle reali nella RAM.

Una pagina virtuale può essere **mappata in qualunque frame** della memoria fisica, grazie alla **[[CPU Units#MMU (Memory Management Unit)|MMU]] (Memory Management Unit)**.

---
### MAPPING VIRTUALE → FISICO

#### Step 1: Divisione dell’indirizzo virtuale

In architettura a 32 bit con pagine da 4 KB (2¹²):

- I **12 bit meno significativi** sono l’**offset** dentro la pagina
- I **20 bit più significativi** sono il **numero della pagina virtuale**

Esempio:

```r
Indirizzo virtuale:   0xABCD1234 
Binario:              1010 1011 1100 1101 0001 0010 0011 0100                                   |-----------------------|-------------|                                   #        N page       offset nella pagina
```

---
#### Step 2: Consultazione della page table

Il sistema operativo tiene per ogni processo una **tabella delle pagine (page table)**, memorizzata in memoria principale (accesso lento), che dice:

- Se la pagina è in RAM o su disco (valid bit)
- In quale frame fisico è mappata

![[Pasted image 20250627171133.png]]
![[Pasted image 20250627171259.png]]

---
#### Step 3: Traduzione

La **MMU**:

- prende il numero di pagina virtuale
- cerca nella page table
- trova il frame fisico corrispondente
- ricompone l’indirizzo fisico: `frame # + offset`

---
### TLB 

Consultare la page table è lento. Quindi, per **velocizzare la traduzione**, si usa una **cache delle traduzioni recenti**: il **TLB** (Translation Lookaside Buffer).

- È una **piccola [[Cache|cache]]** interna alla CPU
- Mappa i **numeri di pagina virtuale → numeri di frame fisico**
- Se la traduzione è trovata nel TLB → **TLB hit** (velocissimo)
- Altrimenti → **TLB miss** → si consulta la page table → si aggiorna il TLB

![[Pasted image 20250627171435.png]]

---
### GESTIONE DI UNA SCRITTURA/LETTURA WRITE-THROUGH

Per il write-through leggere [[Cache#WRITE-THROUGH|qui]]. Qui sotto gli step dell'implementazione con TLB.

![[Pasted image 20250627171815.png]]

---