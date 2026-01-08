UML (Unified Modeling Language) è un linguaggio visivo standardizzato per modellare sistemi software. Aiuta sviluppatori, architetti e analisti a progettare e documentare sistemi tramite diagrammi.

---
### ESEMPIO

```plaintext
+------------------------------+
|      <<package>>             |
|        Model                 |
+------------------------------+
| +--------------------------+ |
| |     Persona              | |
| |--------------------------| |
| | - nome: String           | |
| | - eta: int               | |
| |--------------------------| |
| | + getNome(): String      | |
| | + setEta(int): void      | |
| +--------------------------+ |
|                              |
| +--------------------------+ |
| |    Studente              | |
| |--------------------------| |
| | - matricola: String      | |
| |--------------------------| |
| | + getMatricola(): String | |
| +--------------------------+ |
|                              |
| +--------------------------+ |
| |   Professore             | |
| |--------------------------| |
| | - materia: String        | |
| |--------------------------| |
| | + insegna(): void        | |
| +--------------------------+ |
+------------------------------+

+-----------------------------------+
|      <<package>>                  |
|      Controller                   |
+-----------------------------------+
| +-------------------------------+ |
| | GestioneStudenti              | |
| |-------------------------------| |
| | + aggiungi(s: Studente): void | |
| | + rimuovi(id: String): void   | |
| +-------------------------------+ |
+-----------------------------------+

+--------------------------------+
|      <<package>>               |
|        View                    |
+--------------------------------+
| +----------------------------+ |
| | InterfacciaUtente          | |
| |----------------------------| |
| | + mostraMenu(): void       | |
| | + stampa(p: Persona): void | |
| +----------------------------+ |
+--------------------------------+

```

>**Package `Model`**
>Contiene le classi `Persona`, `Studente` e `Professore`.
>`Studente` e `Professore` **ereditano** da `Persona`.
>I campi sono privati (`-`), mentre i metodi pubblici (`+`).

>**Package `Controller`**
>Contiene la classe `GestioneStudenti` per la logica di gestione.
>Metodi pubblici per aggiungere e rimuovere studenti.

>**Package `View`**
>Contiene `InterfacciaUtente` per la gestione dell'interfaccia grafica.
>Metodi per mostrare il menu e stampare dettagli delle persone.

---
### MODIFICATORI DI VISIBILITA' IN UML

In UML, i **[[Access Modifiers|modificatori di visibilità]]** (o **visibilità degli elementi**) indicano il livello di accesso agli attributi e ai metodi di una classe. Sono rappresentati con simboli davanti ai nomi degli attributi e dei metodi:

| Simbolo | Visibilità   | Accessibile da       |
| ------- | ------------ | -------------------- |
| `+`     | **Pubblico** | Ovunque              |
| `-`     | **Privato**  | Solo nella classe    |
| `#`     | **Protetto** | Classe e sottoclassi |
| `~`     | **Default**  | Stesso pacchetto     |

---
### RELAZIONI TRA CLASSI

In UML le relazioni tra le classi si indicano con **linee e simboli specifici** che permettono di distinguere **che tipo di legame** esiste.  
Ti faccio un riepilogo dei principali casi che hai citato (e qualche extra utile):

---
#### Ereditarietà (Generalization)

**Simbolo**: **Linea continua** con **freccia triangolare vuota** rivolta verso la **superclasse**.
**Significato**: La classe derivata eredita attributi e metodi dalla superclasse.
**Esempio**:

```nginx
Animale ◄──────── Cane
```

---
#### Astrazione (Classe astratta / Metodo astratto)

**Indicazione**: Nome della classe in **corsivo** → indica che la classe è astratta. Metodi astratti in **corsivo** all’interno della classe.
**Relazione**: se una classe concreta implementa una classe astratta, si usa **la stessa freccia dell’ereditarietà**.

---
#### Implementazione di un’interfaccia

**Simbolo**: **Linea tratteggiata** con **freccia triangolare vuota** verso l’interfaccia.
**Esempio**:

```nginx
IMovibile ◄ - - - - Automobile
```

---
#### Associazione

**Cos’è**: Una classe “conosce” o “usa” un’altra classe.
La relazione è **generica** e **non implica possesso**.
La vita di un oggetto **non dipende** dall’altro.
**Simbolo UML**:

```nginx
[ClasseA] ───────── [ClasseB]
```

**Esempio**: `Studente` → `Università`  
Uno studente **può** essere iscritto a un’università, ma può cambiare università e continuare a esistere indipendentemente.

---
#### Aggregazione

**Cos’è**: Una relazione “parte-tutto” ma **le parti possono vivere da sole**.
Il “tutto” contiene le parti, ma se il tutto viene distrutto, le parti **possono continuare a esistere**.
**Simbolo UML**:

```nginx
[ClasseTutto] ◇──────── [ClasseParte]
```

**Esempio**: `Dipartimento` ◇→ `Professore`  
Se il dipartimento viene chiuso, il professore può continuare a lavorare in un altro dipartimento.

---
#### Composizione

**Cos’è**: Una relazione “parte-tutto” ma **le parti non possono vivere senza il tutto**.
La vita delle parti **dipende totalmente** dal tutto.
Quando il tutto viene distrutto, anche le parti lo sono.

**Simbolo UML**:

```nginx
[ClasseTutto] ◆──────── [ClasseParte]
```

**Esempio**: `Casa` ◆→ `Stanza`   
Se la casa viene demolita, anche le stanze scompaiono.

---
### MOLTEPLICITA'

In UML, ogni associazione tra due classi può avere una **molteplicità** (cardinalità) alle estremità, per indicare **quante istanze** di una classe possono essere collegate a un’istanza dell’altra.

Le molteplicità si scrivono come **numeri** vicino alle estremità della linea che unisce le classi.

---
#### Uno a uno 

Ogni istanza di `A` è collegata **esattamente a una** istanza di `B`, e viceversa.
Si rappresenta scrivendo `1` a entrambe le estremità.

**Esempio**:  
Una **Persona** ha un solo **Passaporto**, e un Passaporto appartiene a una sola Persona.

`Persona 1 ---------------- 1 Passaporto`

---
#### Uno a zero o uno

Ogni istanza di `A` è collegata a **zero o una** istanza di `B`.
Si scrive `0..1` da un lato e `1` dall’altro.

**Esempio**:  
Un **Cliente** può avere **zero o una CartaFedeltà**.

`Cliente 1 ---------------- 0..1 CartaFedeltà`

---
#### Uno a molti 

Ogni istanza di `A` può essere collegata a **molte** istanze di `B`, ma ogni `B` appartiene a **una sola** istanza di `A`.
Si scrive `1` da un lato e `*` dall’altro.

**Esempio**:  
Un **Dipartimento** ha molti **Impiegati**, ma ogni Impiegato lavora in un solo Dipartimento.

`Dipartimento 1 ---------------- * Impiegato`

---
#### Molti a molti 

Ogni istanza di `A` può essere collegata a **molte** istanze di `B` e viceversa.
Si scrive `*` su entrambe le estremità.

**Esempio**:  
Uno **Studente** può seguire più **Corsi**, e ogni Corso può avere più Studenti.

`Studente * ---------------- * Corso`

---
#### Range specifico

Puoi indicare un **intervallo numerico**.
Esempi:
- `0..*` → zero o più
- `1..*` → almeno uno
- `2..4` → da due a quattro

**Esempio**:  
Un **Giocatore** deve essere in **almeno una Squadra**, ma può stare anche in più (`1..*`).

`Giocatore 1..* ---------------- 1 Squadra`

---
#### Associazioni opzionali

Se un oggetto può esserci oppure no, si usa `0..1`.
Se può esserci una collezione vuota o piena, si usa `0..*`.

**Esempio**:  
Un **Ordine** può avere **zero o più Prodotti** (`0..*`).

`Ordine 1 ---------------- 0..* Prodotto`

---

