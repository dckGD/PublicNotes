Il **modo di indirizzamento** è il metodo utilizzato da una [[CPU]] per determinare l'operando (cioè il dato) su cui un'istruzione deve operare (la natura dell'operando dipende direttamente dal modo di indirizzamento utilizzato). Ogni architettura di processore ha i suoi modi di indirizzamento, e **[[RISC-V]]** segue una strategia basata sulla semplicità ed efficienza. Ecco i metodi supportati da RISC-V:

---
### INDIRIZZAMENTO IMMEDIATO

**Operazione:** L'operando (il dato) è un valore costante (immediato) incorporato direttamente nell'istruzione.

**Utilizzo:** Utile per operazioni aritmetiche che non richiedono l'accesso alla memoria (come sommare un valore costante).

**Accesso in memoria:** Non viene effettuato alcun accesso in memoria per ottenere il dato, infatti l'operando è già parte dell'istruzione e viene direttamente utilizzato nei calcoli.

**Formato di Istruzione:** [[Instruction Formats#2. FORMATO I (IMMEDIATE-REGISTER)|formato I]]

---

**Esempio:

```assembly
ADDI x5, x0, 10   # x5 = x0 + 10  (dato immediato = 10)
```

L'istruzione aggiunge 10 (immediato) al contenuto del registro x0 (che vale 0) e salva il risultato in x5.

L'immediato `10` è codificato nei bit dell'istruzione (12 bit nel formato I).

Non viene letto nessun dato dalla memoria: il valore 10 è "hard-coded" nell'istruzione stessa.

---
### INDIRIZZAMENTO PER REGISTRO

**Operazione:** L'operando è presente in uno o più registri.

**Utilizzo:** Utile per operazioni aritmetiche o logiche in cui i dati sono già caricati nei registri.

**Accesso in memoria:** Nessun accesso alla memoria avviene in quanto tutti i dati operativi sono già in registri.

**Formato di Istruzione:** [[Instruction Formats#1. FORMATO R (REGISTER-REGISTER)|formato R]]

---

**Esempio:

```assembly
ADD x10, x5, x6   # x10 = x5 + x6
```

L'istruzione somma i contenuti dei registri x5 e x6 e scrive il risultato in x10.

Tutti gli operandi sono presi dai registri; nessuna interazione con la memoria dati.

Il formato R dispone i registri sorgenti (rs1, rs2) e il registro di destinazione (rd) in maniera diretta.

---
### INDIRIZZAMENTO BASE + OFFSET

**Operazione:** L’indirizzo di memoria dell’operando è calcolato sommando il contenuto di un registro (base) a un valore immediato (offset).

**Utilizzo:** Usato per caricare o salvare dati in memoria (ad esempio, per accedere a elementi di array o campi di strutture).

**Accesso in memoria:**

- **Load:** L'istruzione calcola l'indirizzo (base + offset) e legge il dato da memoria.
- **Store:** L'istruzione calcola l'indirizzo (base + offset) e scrive il dato in memoria.

**Formati di Istruzione:**

- **Load:** Utilizza il [[Instruction Formats#2. FORMATO I (IMMEDIATE-REGISTER)|formato I]]
- **Store:** Utilizza il [[Instruction Formats#3. FORMATO S (STORE)|formato S]]

---

**Esempio (Load):

```assembly
LW x10, 4(x5)   # x10 = Mem[x5 + 4]
```

Il registro x5 contiene l'indirizzo base.

L'offset immediato `4` viene sommato a x5 per ottenere l'indirizzo di memoria.

Viene letto un dato (word) da `Mem[x5 + 4]` e memorizzato in x10.

Il formato I contiene l'immediato (offset).

Viene eseguito un singolo accesso in memoria in lettura: il processore accede a `Mem[x5 + 4]`. 

---
### INDIRIZZAMENTO PC RELATIVE

**Operazione:** L'indirizzo di destinazione per un salto o branch è calcolato aggiungendo un offset immediato al valore corrente del [[Program Counter|program counter]] (PC).

**Utilizzo:** Utilizzato per controllare il flusso del programma (salti condizionati e incondizionati).

**Accesso in memoria:** Non vi è un accesso diretto ai dati in memoria (la memoria dati non viene letta o scritta). L'istruzione modifica il PC (il contatore delle istruzioni) in base all'offset.

**Formati di Istruzione:**

- **Branch:** Utilizza il [[Instruction Formats#4. FORMATO B (BRANCH)|formato B]] per salti condizionati.
- **Jump (JAL):** Utilizza il [[Instruction Formats#6. FORMATO J (JUMP)|formato J]] per salti incondizionati.
- **AUIPC:** Utilizza il [[Instruction Formats#5. FORMATO U (UPPER IMMEDIATE)|formato U]] per calcolare indirizzi relativi al PC.

---

**Esempio (Branch):

```assembly
BEQ x5, x6, 16   # Se x5 == x6, PC = PC + 16
```

Se la condizione (x5 == x6) è vera, l'istruzione aggiorna il PC saltando 16 byte in avanti.

Il formato B codifica l'offset in maniera sparsa; il processore lo decodifica e lo somma al PC corrente.

Nessun accesso ai dati in memoria avviene (solo il PC viene modificato).

---
### INDIRIZZAMENTO INDIRETTO

**Operazione:** Il registro contiene direttamente l'indirizzo di memoria da cui leggere o a cui scrivere il dato.

**Utilizzo:** Comune quando si lavora con [[Pointers|puntatori]].

**Accesso in memoria:** L'indirizzo viene preso direttamente dal contenuto di un registro. Viene eseguito un singolo accesso in memoria in lettura (Load) o scrittura (Store).

**Formato di Istruzione:** Per i load, si usa il [[Instruction Formats#2. FORMATO I (IMMEDIATE-REGISTER)|formato I]] con offset zero 

---

**Esempio:

```assembly
LW x10, 0(x5)   # x10 = Mem[x5]
```

x5 contiene l'indirizzo di memoria.

L'istruzione carica il dato presente in `Mem[x5]` in x10.

Il formato I calcola l'indirizzo come `rs1 + imm`, in questo caso `imm` è 0, quindi l'indirizzo è semplicemente il contenuto di x5.

Viene effettuato un accesso in memoria (lettura) in `Mem[x5]`.

---


