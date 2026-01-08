Le **dipendenze funzionali** descrivono **relazioni logiche tra attributi** di una tabella (relazione) e sono fondamentali per la **progettazione corretta** delle basi di dati [[Relational Model|relazionali]].

---
### DEFINIZIONE

Una **dipendenza funzionale** tra due insiemi di attributi **X → Y** significa che:

> in ogni istanza valida della relazione, a ogni valore di **X** corrisponde **uno e un solo valore** di **Y**.

In altre parole, **X determina Y**.  
Se due tuple hanno lo stesso valore per **X**, devono avere anche lo stesso valore per **Y**.

una **relazione** (cioè una tabella) **soddisfa una dipendenza funzionale** X → Y quando, in ogni suo stato possibile, **non esistono due tuple (righe)** che abbiano **lo stesso valore negli attributi di X** ma **valori diversi negli attributi di Y**.

Deve quindi soddisfare:

---
#### Applicabilità:

La dipendenza **X → Y** ha senso solo se **X e Y sono insiemi di attributi dello schema R** (cioè nomi di colonne presenti nella tabella).  

---
#### Condizione logica:

Per **tutte le coppie di tuple** ***t<sub>1</sub>*** e ***t<sub>2</sub>*** nell'istanza di relazione ***r*** :

$$
t_1[X] = t_2[X] \Rightarrow t_1[Y] = t_2[Y]  
$$

**Tradotto:**

> Se due righe hanno gli stessi valori per gli attributi di X, devono per forza avere gli stessi valori per gli attributi di Y.

---
#### Esempio:

Proviamo ad applicare una dipendenza funzionale sulla relazione **Studenti(Matricola, Nome, Cognome, Corso)**, e vediamo se sono soddisfatte applicabilità e condizione logica:
![[fd logic condition.png]]Qui vale **Matricola → Nome, Cognome, Corso** perché;
**Applicabilità:** soddisfatta in quanto tutti gli attributi di **X** (**Matricola**) e di **Y** (**Nome, Cognome, Corso**) si trovano in **R**.
**Condizione logica:** soddisfatta in quanto non esistono due o più tuple con stessa **Matricola** e **Nome, Cognome, Corso** diversi, ad esempio: dove **Matricola** = `101`, i valori di **Nome**, **Cognome** e **Corso** coincidono in tutte le tuple (`Giulio, Dionisi, Informatica`). Non varrebbe se comparisse una tupla `(101, Riccardo, Finocchiaro, Informatica)`: stessa **Matricola**, ma **Nome** e **Cognome** diversi, dunque è una violazione.

---
### ASSIOMI DI ARMSTRONG

Le **regole di Armstrong** sono un insieme di **assiomi** che permettono di dedurre tutte le **dipendenze funzionali implicite** da un insieme **F**. Sono fondamentali per il calcolo della **[[Functional Dependencies#CHIUSURA SEMANTICA|chiusura]]** e per la progettazione logica delle basi di dati.

---
#### Riflessività (reflexivity)

Se **Y ⊆ X**, allora

$$X → Y$$

**Significato:** un insieme di attributi determina sempre se stesso o un suo sottoinsieme.

**Esempio:**  

Se **X = AB**, allora vale: **AB → A, AB → B**.

---
#### Aumento (Augmentation)

Se **X → Y**, allora per ogni insieme di attributi **Z**:  

$$XZ → YZ $$

**Esempio:**  

Se **B → AD** e nello schema **R** ho anche l'attributo **C**, allora vale: **BC → ACD**.

---
#### Transitività (Transitivity)

Se **X → Y** e **Y → Z**, allora  

$$X → Z$$

**Esempio:**  

Se **B → AD** e  **AD → C**, allora vale: **B → C**.

---
### REGOLE DERIVATE

Dagli **assiomi di Armstrong** si possono derivare altre regole **regole secondarie** come conseguenze logiche degli assiomi:

---
#### Unione (Union / Additivity)

Se **X → Y** e **X → Z**, allora

$$X → YZ$$

**Dimostrazione:**

Se **X → Y** allora per [[Functional Dependencies#Aumento (Augmentation)|aumento]]: **XX → YX**, che equivale a scrivere **X → YX** (insiemi).
Analogamente, se **X → Z** allora per [[Functional Dependencies#Aumento (Augmentation)|aumento]]: **XY → YZ**. 
Quindi, poiché **X → YX** e **XY → YZ**, per [[Functional Dependencies#Transitività (Transitivity)|transitività]]: **X → YZ**.

---
#### Decomposizione (Decomposition / Projectivity)

Se **X → YZ**, allora  

$$X \to Y \quad \text{e} \quad X \to Z$$

**Dimostrazione:**

Poiché **Y ⊆ YZ**, allora per [[Functional Dependencies#Riflessività (reflexivity)|riflessività]]: **YZ → Y**.
Dunque applicando la [[Functional Dependencies#Transitività (Transitivity)|transitività]] a **X → YZ** e **YZ → Y** ricaviamo **X → Y**.
Analogamente, poiché **Z ⊆ YZ** allora per [[Functional Dependencies#Riflessività (reflexivity)|riflessività]]; **YZ → Z**.
Dunque applicando la [[Functional Dependencies#Transitività (Transitivity)|transitività]] a **X → YZ** e **YZ → Z** ricaviamo **X → Z**.

---
#### Pseudo-Transitività

Se **X → Y** e **YZ → W**, allora  

$$XZ \to W$$

**Dimostrazione:**

Se **X → Y** allora per [[Functional Dependencies#Aumento (Augmentation)|aumento]]: **XZ → YZ**.
Quindi, poiché **XZ → YZ** e **YZ → W**, per [[Functional Dependencies#Transitività (Transitivity)|transitività]]: **XZ → W**.

---
### CHIUSURA SEMANTICA

Uno **[[Relational Model#Schema|schema di relazione]]** <b>R = {A<sub>1</sub>, A<sub>2</sub>, ..., A<sub>n</sub>}</b> ricordiamo essere l’insieme di attributi di una relazione. Dunque possiamo scrivere **l’insieme F di tutte le DF conosciute** nello schema **R** come:

$$F = \{ X_1 \to Y_1, X_2 \to Y_2, ..., X_k \to Y_k \}$$

Dato uno schema di relazione **R** e un insieme di dipendenze funzionali **F** su **R**, definiamo <b>F<sup>+</sup></b> l'insieme di **tutte le dipendenze funzionali** che si possono **dedurre logicamente** da **F**. Quindi <b>F<sup>+</sup></b> è l’insieme di tutte le dipendenze funzionali che sono soddisfatte da **ogni istanza legale di R**: contiene sia le **DF** già presenti in **F** (infatti **F ⊆** <b>F<sup>+</sup></b>) che le **DF** che si possono **dedurre da F usando gli [[Functional Dependencies#ASSIOMI DI ARMSTRONG|assiomi di Armstrong]]**.

---

**Esempio:**

Schema: **R = { A, B, C }**
Insieme minimale delle dipendenze funzionali su R: **F = { A → B, B → C }**
Chiusura di **F**: **F<sup>+</sup> = { A → B, B → C, A → C, A → A, B → B, C → C }**

> Qui **A → C** è implicita, quindi non serve inserirla in F per rendere l’istanza legale: basta F.

---
### CHIUSURA SINTATTICA

Sia **F** un insieme di **DF** su uno schema **R**. Denotiamo con <b>F<sup>A</sup></b> l’insieme ottenuto a partire da **F** chiudendo ricorsivamente usando solo gli [[Functional Dependencies#ASSIOMI DI ARMSTRONG|assiomi]] di **riflessività**, **aumento** e **transitività** (**chiusura sintattica di F**). Si può dimostrare che:

$$F^+=F^A$$

Cioè che la chiusura <b>F<sup>+</sup></b> di un insieme di dipendenze funzionali **F** può essere ottenuta a partire da **F** applicando ricorsivamente solo gli **assiomi di Armstrong**. (Questo teorema stabilisce che **le dipendenze vere in tutte le istanze legali rispetto a F** coincidono esattamente con quelle **ottenibili applicando gli assiomi di Armstrong**).

---

Dunque **definiamo** <b>F<sup>A</sup></b> nel seguente modo:

- se **f ∈ F** allora **f ∈** <b>F<sup>A</sup></b> (**F ⊆** <b>F<sup>A</sup></b>)
- se **Y ⊆ X ⊆ R** allora **X → Y ∈** <b>F<sup>A</sup></b> (assioma della [[Functional Dependencies#Riflessività (reflexivity)|riflessività]])
- se **X → Y ∈** <b>F<sup>A</sup></b> allora **XZ → YZ ∈** <b>F<sup>A</sup></b> , per ogni **Z ⊆ R** (assioma dell’[[Functional Dependencies#Aumento (Augmentation)|aumento]])
- se **X → Y ∈** <b>F<sup>A</sup></b> e **Y → Z ∈** <b>F<sup>A</sup></b> allora **X → Z ∈** <b>F<sup>A</sup></b> (assioma della [[Functional Dependencies#Transitività (Transitivity)|transitività]])

---

**Dimostrazione:**

Dimostriamo l'uguaglianza <b>F<sup>+</sup>= F<sup>A</sup></b> dimostrando la doppia inclusione:

---
#### Prima inclusione: 

Dimostriamo che <b>F<sup>A</sup> ⊆ F<sup>+</sup></b>:

> "Tutte le dipendenze funzionali che si possono verificare con gli assiomi di Armstrong (<b>∈ F<sup>A</sup></b>) sono anche vere in ogni istanza legale (<b>∈ F<sup>+</sup></b>)".

---

Indichiamo con <b>F<sub>i</sub></b> **l’insieme delle dipendenze funzionali ottenute dopo *i* applicazioni degli assiomi di Armstrong** a partire da **F**. Quindi:
<b>F<sub>0</sub> = F</b> ...
<b>F<sub>1</sub></b> = tutte le dipendenze ottenute da <b>F<sub>0</sub></b> applicando una volta uno qualsiasi dei tre assiomi...
<b>F<sub>2</sub></b> = tutte quelle ottenute applicando ancora una volta uno qualsiasi dei tre assiomi su <b>F<sub>1</sub></b>...
e così via.
L’unione di tutti questi insiemi costituisce <b>F<sup>A</sup></b>:

$$F^A = \bigcup_{i \ge 0} F_i$$

> In altre parole, <b>F<sup>A</sup></b> è il risultato di applicare **ricorsivamente** gli assiomi di Armstrong **fino a chiusura** cioè finché non si ottengono più nuove dipendenze.

---

**Caso base (*i* = 0):**

$$F_0​=F⊆F^+⟹F_0​⊆F^+$$

Per [[Functional Dependencies#CHIUSURA SEMANTICA|definizione]], tutte le dipendenze in **F** appartengono a <b>F<sup>+</sup></b>, perché <b>F<sup>+</sup></b> è l’insieme di _tutte_ le dipendenze implicate da **F**. Caso base verificato.

---

**Ipotesi induttiva:**

$$F_i​⊆F^+$$

Si assume che tutte le dipendenze ottenute con **al più *i* applicazioni** degli assiomi di Armstrong siano già in <b>F<sup>+</sup></b>.

---

**Passo induttivo (*i* > 0):**

$$F_{i+1​}⊆F^+$$

Bisogna mostrare che anche ogni dipendenza in <b>F<sub>i+1</sub></b> è ottenuta applicando **una sola volta in più** uno dei tre assiomi di Armstrong su dipendenze già contenute in <b>F<sub>i</sub>​</b>.

Ora si considerano i tre casi in cui la nuova **X → Y** può essere stata ottenuta:

---

**Caso 1:**

**X → Y** è stata ottenuta mediante l’assioma della [[Functional Dependencies#Riflessività (reflexivity)|riflessività]], in tal caso **Y ⊆ X**. 

Sia ***r*** un’istanza di **R** e siano ***t<sub>1</sub>*** e ***t<sub>2</sub>*** due tuple di ***r*** tali che:

$$t_1[X]=t_2[X]$$

Per l'ipotesi induttiva, da **Y ⊆ X** e **X → Y** segue che:

$$t_1[Y]=t_2[Y]$$
Dunque **X → Y**, se ottenuta per riflessività, è **una dipendenza logicamente vera** (valida in ogni relazione), cioè appartiene a <b>F<sup>+</sup></b>.

---

**Caso 2:**

**X → Y** è stata ottenuta applicando l’assioma dell'[[Functional Dependencies#Aumento (Augmentation)|aumento]] ad una dipendenza funzionale **V → W** in <b>F<sup>A</sup></b>, che a sua volta è stata ottenuta applicando ricorsivamente gli assiomi di Armstrong un numero di volte **≤ i−1** (quindi per ipotesi induttiva, **V → W ∈** <b>F<sup>+</sup></b>).

Dunque si ha **X = VZ e Y = WZ** per qualche insieme di attributi **Z ∈ R**.

Sia ***r*** un’istanza di **R** e siano ***t<sub>1</sub>*** e ***t<sub>2</sub>*** due tuple di ***r*** tali che:

$$t_1[X]=t_2[X]$$

Dato che ***r*** è legale e **X = VZ** si ha anche:

$$t_1[V] = t_2[V] \quad e \quad  t_1[Z] = t_2[Z]$$

E per ipotesi induttiva, da **V → W ∈** <b>F<sup>+</sup></b> segue che:

$$t_1[W]=t_2[W]$$

Unendo:

$$t_1[W] = t_2[W] \quad e \quad t_1[Z] = t_2[Z]$$

 otteniamo:

$$ t_1[WZ] = t_2[WZ], \quad ovvero \quad t_1[Y] = t_2[Y]$$

Dunque **X → Y** (**VZ → WZ**), se ottenuta per aumento su **V → W ∈** <b>F<sup>+</sup></b>, allora è una **dipendenza logicamente vera** (valida in ogni relazione), cioè appartiene a <b>F<sup>+</sup></b>.

---

**Caso 3:**

**X → Y** è stata ottenuta applicando l’assioma della [[Functional Dependencies#Transitività (Transitivity)|transitività]] a due dipendenze funzionali **X → Z** e **Z → Y** in <b>F<sup>A</sup></b>, ottenute a loro volta applicando ricorsivamente gli assiomi di Armstrong un numero di
volte **≤ i−1** (quindi per ipotesi induttiva, **X → Z** e **Z → Y ∈** <b>F<sup>+</sup></b>).

Sia ***r*** un’istanza di **R** e siano ***t<sub>1</sub>*** e ***t<sub>2</sub>*** due tuple di ***r*** tali che:

$$t_1[X]=t_2[X]$$

Per l'ipotesi induttiva, da <b>X → Z ∈ F<sup>+</sup></b> segue che:

$$t_1[Z] = t_2[Z]$$

E, sempre per l'ipotesi induttiva, da <b>Z → Y ∈ F<sup>+</sup></b> segue che:

$$t_1[Y] = t_2[Y]$$

Dunque **X → Y**, se ottenuta per transitività su **X → Z** e **Z → Y ∈** <b>F<sup>+</sup></b>, allora è una **dipendenza logicamente vera** (valida in ogni relazione), cioè appartiene a <b>F<sup>+</sup></b>.

---

**Conclusione:**

In tutti i tre casi (riflessività, aumento, transitività), la nuova dipendenza **X → Y** ottenuta da quelle precedenti risulta **logicamente implicata** da **F**. Quindi per induzione:

$$F^A⊆F^+$$

---
#### Seconda inclusione: 

Dimostriamo che <b>F<sup>+</sup> ⊆ F<sup>A</sup></b>:

> "Ogni dipendenza funzionale logicamente vera rispetto a F (<b>∈ F<sup>+</sup></b>) è anche deducibile sintatticamente tramite gli assiomi di Armstrong (<b>∈ F<sup>A</sup></b>)".

---

Supponiamo per assurdo che esista una dipendenza funzionale 

$$X → Y ∈F^+ \quad | \quad X → Y ∉ F^A$$

Useremo una particolare istanza legale di **R** per dimostrare che questa supposizione porta ad una contraddizione.

---

**Costruzione dell'istanza *r* :**

Per arrivare alla contraddizione, si costruisce un’istanza artificiale **r** dello schema **R** con **solo due tuple**, così:
![[special instance.png]]Le due tuple sono **uguali su tutti gli attributi di** <b>X<sup>+</sup></b>, ma **diverse su tutti gli altri attributi (R − <b>X<sup>+</sup></b>)**.
Questa costruzione serve per **“testare” la validità delle dipendenze**:

- Se una dipendenza ha il determinante (parte sinistra) tutto dentro <b>X<sup>+</sup></b>, allora le due tuple avranno **gli stessi valori** su quella parte.
- Se ha il determinato (parte destra) almeno un attributo fuori da <b>X<sup>+</sup></b>, allora le due tuple avranno **valori diversi** su quella parte.

---

**Verifica della legalità di *r* :**

Ora bisogna mostrare che **r soddisfa tutte le dipendenze in F** (cioè è legale).
Supponiamo **per assurdo** che una dipendenza di **F**, ad esempio **V → W**, **non sia soddisfatta** da ***r***.  
Affinché ciò accada le due tuple devono essere:
- **Uguali su V**: significa che **V ⊆ <b>X<sup>+</sup></b>** (perché le tuple coincidono proprio su <b>X<sup>+</sup></b>);
- **Diverse su W**:  quindi **W ∩ (R − <b>X<sup>+</sup></b>) ≠ ∅** (cioè W contiene almeno un attributo non in <b>X<sup>+</sup></b>).
Tuttavia:
Se **V ⊆ <b>X<sup>+</sup></b>**, dal **[[Functional Dependencies#Lemma 1|Lemma]]** sappiamo che **X → V ∈ Fᴬ**, e siccome anche **V → W ∈ F** ⊆ **Fᴬ**, per **[[Functional Dependencies#Transitività (Transitivity)|transitività]]** otteniamo **X → W ∈ Fᴬ**. Sempre dal **Lemma**, questo implicherebbe **W ⊆ <b>X<sup>+</sup></b>**, **che contraddice** la condizione **W ∩ (R − <b>X<sup>+</sup></b>) ≠ ∅**.
Abbiamo dimostrato per assurdo che: **tutte le dipendenze in F sono soddisfatte da *r* (*r* è legale).**

---

**Verifica della contraddizione finale:**

Ora, siccome **X → Y ∈ F⁺**, significa che **tutte le istanze legali**, compresa ***r***, devono soddisfarla.
Ma [[special instance.png|osserviamo]] ***r*** :
- Le due tuple coincidono su **X** (perché **X ⊆ <b>X<sup>+</sup></b>** per [[Functional Dependencies#Riflessività (reflexivity)|riflessività]]).
- Dunque devono coincidere anche su **Y**, se ***r*** soddisfa **X → Y** (per la [[Functional Dependencies#Condizione logica|definizione]] di dipendenza funzionale).
Questo implica che **Y ⊆ <b>X<sup>+</sup></b>** (cioè gli attributi di Y sono determinati da X, per la [[Functional Dependencies#CHIUSURA DI UN INSIEME DI ATTRIBUTI|definizione]] di <b>X<sup>+</sup></b>).  
Ma dal **[[Functional Dependencies#Lemma 1|Lemma]] precedente**, **Y ⊆ <b>X<sup>+</sup></b> ⇔ X → Y ∈ Fᴬ**. Ecco dunque la **contraddizione**:
Avevamo assunto inizialmente che:

$$X → Y ∈ F^+ \quad | \quad X → Y ∉ F^A$$

Ma abbiamo appena dimostrato che:

$$Y ⊆ X^+ ⇒  X → Y \in F^A$$

---

**Conclusione:**

Arrivando alla contraddizione precedente abbiamo dimostrato per assurdo che:

$$F^+⊆F^A$$

---
#### Conclusione finale:

Dimostrando per induzione che <b>F<sup>A</sup> ⊆ F<sup>+</sup></b> e per assurdo che <b>F<sup>+</sup> ⊆ F<sup>A</sup></b> siamo arrivati alla conclusione che: 

$$F^+=F^A$$

---
### CHIUSURA DI UN INSIEME DI ATTRIBUTI

Siano **R** uno schema di relazione, **F** un insieme di dipendenze funzionali su **R** e **X** un sottoinsieme di attributi di **R**. La chiusura di **X** rispetto ad **F**, denotata con <b>X<sup>+</sup><sub>F</sub></b> (o semplicemente <b>X<sup>+</sup></b>, se non sorgono ambiguità) è definita nel modo seguente:

$$X^+_F =\{A\ |\ X \rightarrow A \in F^+\}$$

In pratica <b>X<sup>+</sup></b> è l’insieme contenente tutti gli attributi **A<sub>i</sub>** **determinati** da **X** usando le dipendenze funzionali in <b>F<sup>+</sup></b>.

---
#### Lemma 1:

Sia **R** uno schema di relazione e **F** un insieme di dipendenze funzionali.  
Allora:

$$X \to Y \in F^A \iff Y \subseteq X^+$$

cioè:

> “**X** determina **Y**” se e solo se tutti gli attributi di **Y** appartengono alla chiusura <b>X<sup>+</sup></b> di **X**" (dopotutto <b>X<sup>+</sup></b> è proprio l'insieme degli attributi determinati da **X**).

---

**Dimostrazione:**

**1. Se X → Y ∈ <b>F<sup>A</sup></b> allora <b>Y ⊆ X<sup>+</sup></b> (⇒):**
Supponiamo che **X → Y ∈** <b>F<sup>A</sup></b>.
Per la **regola della [[Functional Dependencies#Decomposizione (Decomposition / Projectivity)|decomposizione]]**, da **X → Y** segue che:
<b>X → A<sub>i</sub> ∈ F<sup>A</sup></b> per ogni attributo <b>A<sub>i</sub> ∈ Y</b>.
Per definizione di chiusura <b>X<sup>+</sup></b>, per ogni <b>A<sub>i</sub> ∈ Y</b>:

$$A_i ∈ X^+\quad se\quad ​X → A_i$$

Quindi <b>Y ⊆ X<sup>+</sup></b>.

**2. Se <b>Y ⊆ X<sup>+</sup></b> allora X → Y ∈ <b>F<sup>A</sup></b> (⇐):**
Supponiamo che <b>Y ⊆ X<sup>+</sup></b>.
Per definizione di chiusura <b>X<sup>+</sup></b>, per ogni <b>A<sub>i</sub> ∈ Y</b>: 

$$X → A_i ∈ F^A$$

Per la **regola dell’[[Functional Dependencies#Unione (Union / Additivity)|unione]]** da tutte le singole dipendenze <b>X → A<sub>1</sub></b>, <b>X → A<sub>2</sub></b>, ..., <b>X → A<sub>n</sub></b> segue che:
<b>X → A<sub>1</sub> A<sub>2</sub> ... A<sub>n</sub></b> = **Y**.
Quindi **X → Y ∈** <b>F<sup>A</sup></b>.

---
#### Calcolo di X<sup>+</sup>:

Il calcolo di <b>X<sup>+</sup></b> è utile per verificare se una dipendenza funzionale **X → Y** appartiene ad <b>F<sup>+</sup></b>. Infatti dal [[Functional Dependencies#Lemma 1|lemma]]: **X → Y ∈ <b>F<sup>A</sup></b> ⇔ <b>Y ⊆ X<sup>+</sup></b>** e abbiamo [[Functional Dependencies#CHIUSURA SINTATTICA|dimostrato]] anche che <b>F<sup>A</sup>= F<sup>+</sup></b>. Per calcolare <b>X<sup>+</sup></b> possiamo utilizzare un algoritmo noto.

---
##### Algoritmo calcolo X<sup>+</sup>:

```r
begin
	Z := X
	S := { A | (Y → V ∈ F) ∧ (A ∈ V) ∧ (Y ⊆ Z) }
	while S ⊄ Z do:
	begin
		Z := Z ∪ S
		S := { A | (Y → V ∈ F) ∧ (A ∈ V) ∧ (Y ⊆ Z) }
	end
end
```

- **Input:** uno schema **R**, un insieme di dipendenze funzionali **F** su **R**, un sottoinsieme **X** di **R**.
- **Output:** la chiusura <b>X<sup>+</sup></b> di **X** rispetto ad **F** (restituita nella variabile **Z**).

---

**Idea di base:**

Partiamo dagli attributi di **X** e cerchiamo iterativamente di aggiungere a <b>X<sup>+</sup></b> tutti gli attributi che possono essere determinati usando le **DF** di **F**. Il processo termina quando non possiamo più aggiungere nulla.

> N.B. l’algoritmo calcola <b>X<sup>+</sup></b> usando solo le dipendenze di **F**, perché è garantito che applicando gli [[Functional Dependencies#ASSIOMI DI ARMSTRONG|assiomi di Armstrong]] su **F** si ottiene implicitamente tutto ciò che c’è in <b>F<sup>+</sup></b>.

---

**Inizializzazione:**

**Z** sarà la variabile che contiene <b>X<sup>+</sup></b>. 

```r
Z := X
```

All’inizio conosciamo solo che **X** determina se stesso (per [[Functional Dependencies#Riflessività (reflexivity)|riflessività]]), quindi **X ⊆** <b>X<sup>+</sup></b>.

---

**Scelta delle DF applicabili:**

**S** è l’insieme degli attributi che possiamo ricavare da **F** usando ciò che abbiamo già in **Z**

```r
S := { A | (Y → V ∈ F) ∧ (A ∈ V) ∧ (Y ⊆ Z) }
```

Aggiungo ad **S** l'attributo **A** tale che:

- **Y → V ∈ F**: stiamo considerando una dipendenza funzionale in **F**.
- **Y ⊆ Z**: l'insieme **Y** dei determinanti è già contenuto in **Z** (<b>X<sup>+</sup></b>), quindi è applicabile.
- **A ∈ V**: **A** deve far parte dell'insieme **V** dei determinati.

---

**Ciclo di espansione:**

```r
while S ⊄ Z do:
```

Se **S** contiene attributi non ancora in **Z**, allora possiamo espandere **Z**.

```r
Z := Z ∪ S
```

Aggiungiamo **S** a **Z**.

```r
S := { A | (Y → V ∈ F) ∧ (A ∈ V) ∧ (Y ⊆ Z) }
```

Ricalcoliamo **S**, perché ora abbiamo nuovi attributi in **Z** e potrebbero essere applicabili nuove dipendenze funzionali.

Continuiamo finché **S** non aggiunge più nulla (cioè **S ⊆ Z**).

---
##### Esempio:

Vogliamo calcolare la chiusura <b>AB<sup>+</sup></b> di **AB** nel seguente schema:

**Input:**
**R = ABCDEHL**
**F = { AB → C, B → D, AD → E, CE → H }**

**Z = AB** per [[Functional Dependencies#Riflessività (reflexivity)|riflessività]].
**S = { A | (Y → V ∈ F) ∧ (A ∈ V) ∧ (Y ⊆ AB) }**
Aggiungo ad **S** tutti gli attributi che posso determinare da **AB**:
**AB → C**
**B → D**
**S = CD**.

**S ⊆ Z ?**: 
**CD ⊄ AB**, quindi entro nel ciclo:
**Z = AB ∪ S = ABCD**.
**S = { A | (Y → V ∈ F) ∧ (A ∈ V) ∧ (Y ⊆ ABCD) }**
Aggiungo ad **S** tutti gli attributi che posso determinare da **ABCD**:
**AB → C**, **B → D**
**AD → E**
**S = CDE**.

**S ⊆ Z ?**: 
**CDE ⊄ ABCD**, quindi entro nel ciclo:
**Z = ABCD ∪ S = ABCDE**.
**S = { A | (Y → V ∈ F) ∧ (A ∈ V) ∧ (Y ⊆ ABCDE) }**
Aggiungo ad **S** tutti gli attributi che posso determinare da **ABCDE**:
**AB → C**, **B → D**, **AD → E** 
**CE → H** 
**S = CDEH**.

**S ⊆ Z ?**: 
**CDEH ⊄ ABCDE**, quindi entro nel ciclo:
**Z = ABCDE ∪ S = ABCDEH**.
Aggiungo ad **S** tutti gli attributi che posso determinare da **ABCDEH**:
**AB → C**, **B → D**, **AD → E**, **CE → H** 
Non ci sono nuove **DF**.
**S = CDEH**.

**S ⊆ Z ?**: 
**CDEH ⊆ ABCDEH**, quindi esco dal ciclo.

**Output:** 
<b>AB<sup>+</sup></b> **= Z = ABCDEH**.

---
##### Teorema sulla validità dell'algoritmo calcolo X<sup>+</sup>:

L’algoritmo calcola correttamente la chiusura <b>X<sup>+</sup></b> di un insieme di attributi **X** rispetto ad un insieme **F** di dipendenze funzionali.

---

**Dimostrazione:**

Indichiamo con <b>Z<sub>0</sub></b> il valore iniziale di **Z** (<b>Z<sub>0</sub></b> **= X**) e con <b>Z<sub>i</sub></b> ed <b>S<sub>i</sub></b>, con  ***i* ≥ 1**, i valori di **Z** ed **S** dopo l’***i*-esima** esecuzione del corpo del ciclo. Facile vedere che, per ogni ***i***:

$$Z_i⊆ Z_{i+1}$$

> Ricorda: In <b>Z<sub>i</sub></b> ci sono gli attributi aggiunti a **Z** fino alla ***i*-esima** iterazione. Alla fine di ogni iterazione aggiungiamo qualcosa a **Z** da **S**, ma **non eliminiamo mai** nessun attributo in **Z**.

Sia ***j*** tale che <b>S<sub>j</sub></b> **⊆** <b>Z<sub>j</sub></b> (cioè <b>Z<sub>j</sub></b> **= valore di Z al termine dell'algoritmo =** <b>X<sup>+</sup></b>), dimostriamo che:

$$A \in Z_j  \iff A \in X^+$$

---

**1. Se A ∈ <b>Z<sub>j</sub></b> allora A ∈ <b>X<sup>+</sup></b> (⇒):**

**Caso base (*i* = 0):**

$$Z_0​=X⊆X^+⟹Z_0​⊆X^+$$

Per [[Functional Dependencies#Riflessività (reflexivity)|riflessività]], tutti gli attributi in **X** appartengono a <b>X<sup>+</sup></b>, perché <b>X<sup>+</sup></b> è l’insieme di _tutti_ gli attributi determinati a partire da **X**. Caso base verificato.

---

**Ipotesi induttiva:** 

$$Z_{i-1}​⊆X^+$$

Si assume che tutti gli attributi ottenuti con **al più *i* - 1 iterazioni** dell'algoritmo siano già in <b>X<sup>+</sup></b>.

---

**Passo induttivo (*i* > 0):**

Sia **A** un attributo in **<b>Z<sub>i</sub></b> - <b>Z<sub>i-1</sub></b>** (ovvero aggiunto a **Z** durante l'***i*-esima** iterazione):
Deve esistere, secondo l'[[Functional Dependencies#Algoritmo calcolo X<sup>+</sup>|algoritmo]], una dipendenza **Y → V ∈ F** tale che <b>Y ⊆ Z<sub>i-1</sub></b> e **A ∈ V**.
Poiché <b>Y ⊆ Z<sub>i-1</sub></b>, allora per l'**ipotesi induttiva**: <b>Y ⊆ X<sup>+</sup></b>.
Pertanto, per il [[Functional Dependencies#Lemma 1|lemma]]: <b>Y ⊆ X<sup>+</sup></b> ⟹ **X → Y ∈** <b>F<sup>A</sup></b>.
Per [[Functional Dependencies#Transitività (Transitivity)|transitività]]: Se **X → Y ∈** <b>F<sup>A</sup></b> e **Y → V ∈ F**, allora **X → V ∈** <b>F<sup>A</sup></b>.
Pertanto, sempre per il [[Functional Dependencies#Lemma|lemma]]: **X → V ∈** <b>F<sup>A</sup></b> ⟹ <b>V ⊆ X<sup>+</sup></b>.
Dunque, in quanto **A ∈ V** e <b>V ⊆ X<sup>+</sup></b>, allora <b>A ∈ X<sup>+</sup></b>, per ogni **A ∈ <b>Z<sub>i</sub></b> - <b>Z<sub>i-1</sub></b>**.
Abbiamo  quindi dimostrato che <b>Z<sub>i</sub></b> - <b>Z<sub>i-1</sub></b> **⊆** <b>X<sup>+</sup></b>.
Sapendo anche che, per l'ipotesi induttiva, <b>Z<sub>i-1</sub></b> **⊆** <b>X<sup>+</sup></b>, possiamo affermare che:

$$Z_i​⊆X^+$$

---

**2. Se A ∈ <b>X<sup>+</sup></b> allora A ∈ <b>Z<sub>j</sub></b> (⇐):**

**Costruzione dell'istanza *r* :**

Per poter dimostrare, si costruisce un’istanza artificiale **r** dello schema **R** con **solo due tuple**, così:
![[special instance 1.png]]
Le due tuple sono **uguali su tutti gli attributi di** <b>Z<sub>j</sub></b>, ma **diverse su tutti gli altri attributi (R − <b>Z<sub>j</sub></b>)**.

---

**Verifica della legalità di *r* :**

Ora bisogna mostrare che **r soddisfa tutte le dipendenze in F** (cioè è legale).
Data una qualsiasi dipendenza funzionale **V → W** in **F**:

> Ricorda: Una dipendenza funzionale **V → W** in **F** è violata se <b>t<sub>1</sub>[V] = t<sub>2</sub>[V] e t<sub>1</sub>[W] ≠ t<sub>2</sub>[W]</b>.

Se **V ⊄ <b>Z<sub>j</sub></b>** allora <b>t<sub>1</sub>[V] ≠ t<sub>2</sub>[V]</b> perché c'è almeno un attributo di **V** in **R − <b>Z<sub>j</sub></b>** cioè **V ∩ (R − <b>Z<sub>j</sub></b>) ≠ Ø** e quindi la dipendenza è soddisfatta. 

Se **V ⊆ <b>Z<sub>j</sub></b>** allora <b>t<sub>1</sub>[V] = t<sub>2</sub>[V]</b> quindi: se le due tuple avessero valori diversi su **W**, cioè **W ∩ (R − <b>Z<sub>j</sub></b>) ≠ Ø** la dipendenza non sarebbe soddisfatta (<b>t<sub>1</sub>[W] ≠ t<sub>2</sub>[W]</b>). Allo stesso tempo però si avrebbe anche che **<b>S<sub>j</sub></b> ⊄ <b>Z<sub>j</sub></b>**, ovvero <b>Z<sub>j</sub></b> non sarebbe il valore finale di **Z** (ma questo è in contraddizione con la nostra costruzione dell'istanza) infatti:
L'[[Functional Dependencies#Algoritmo calcolo X<sup>+</sup>|algoritmo]] costruisce <b>S<sub>j</sub></b> (l'insieme **S** all'ultima iterazione) come: 

$$S_j​=\{\ A∣∃\ V→W∈F\ ∧\ V⊆Z_j\ ​∧\ A∈W\ \}$$

> Ricorda: <b>S<sub>j</sub></b> contiene tutti gli attributi che devono essere aggiunti a **Z** perché derivano da **DF** applicabili a <b>Z<sub>j</sub></b>.

Normalmente **<b>S<sub>j</sub></b> ⊆ <b>Z<sub>j</sub></b>** quindi non si dovrebbe avere una nuova iterazione e l'algoritmo dovrebbe terminare restituendo <b>Z<sub>j</sub></b>. Tuttavia in questo caso, prendendo **A** in **W ∩ (R − <b>Z<sub>j</sub></b>) ≠ Ø**:

$$ V \subseteq Z_j \ \land \  W \cap (R - Z_j) \neq \varnothing \ \Rightarrow \  S_j \not\subseteq Z_j \ \Rightarrow \  Z_{j+1} \neq Z_j $$

Dato che **V ⊆ <b>Z<sub>j</sub></b>** in questo caso è vero, **V → W** sarebbe applicabile, quindi **A** dovrebbe entrare in <b>S<sub>j</sub></b>.
Di conseguenza **Sⱼ ⊄ <b>Z<sub>j</sub></b>**, quindi **A entrerebbe in Z** all’iterazione successiva (<b>Z<sub>j+1</sub></b>):
Ma abbiamo scelto <b>Z<sub>j</sub></b> come valore finale di **Z**, quindi per forza: **Sⱼ ⊆ <b>Z<sub>j</sub></b>**, siamo giunti a una contraddizione. 

Quindi la dipendenza **V → W** in **F** è soddisfatta anche quando le due tuple hanno valori uguali su V, e dunque l’istanza è legale.

---

**Verifica che A ∈ <b>Z<sub>j</sub></b>:**

Abbiamo già mostrato che l’istanza ***r*** costruita **è legale**, cioè soddisfa **tutte** le dipendenze funzionali in **F** e quindi anche **tutte le dipendenze in <b>F<sup>+</sup></b>.

Ora consideriamo la dipendenza funzionale che ci interessa:

$$X→A∈F^+$$

Poiché ***r*** è legale, tutte le DF in <b>F<sup>+</sup></b> devono valere nell’istanza, quindi anche **X → A**, verifichiamo:
Per l'[[Functional Dependencies#Algoritmo calcolo X<sup>+</sup>|algoritmo]]:

$$Z_0 = X \subseteq Z_j$$

E nella nostra costruzione le due tuple <b>t<sub>1</sub></b>​ e <b>t<sub>2</sub>​</b> sono **uguali su tutti gli attributi di <b>Z<sub>j</sub></b>​**. Dunque:

$$t_1[X] = t_2[X]$$

Quindi nell’istanza ***r*** le due tuple concordano sul determinante **X**.
Poiché ***r*** è legale, deve soddisfare anche:

$$t_1[A] = t_2[A]$$

Questo (data la [[special instance 1.png|costruzione]] di **r**) è possibile solo se **A ∈ <b>Z<sub>j</sub></b>**, in quanto se **A ∈ <b>R - Z<sub>j</sub></b>** avremmo <b>t<sub>1</sub>[A] ≠ t<sub>2</sub>[A]</b> e **X → A ∈ <b>F<sup>+</sup></b>** non sarebbe soddisfatta. Quindi **A ∈ <b>X<sup>+</sup></b>** **⇒** **A ∈ <b>Z<sub>j</sub></b>** è dimostrato.

---
### CHIAVI

Dati uno **schema di relazione R** e un **insieme di dipendenze funzionali F**, un **insieme di attributi K ⊆ R** è una **[[Relational Model#Chiave|chiave]]** di **R** se soddisfa **due condizioni**:

---

**Unicità:** 

$$K \to R \in F^+$$

Significa che **K determina tutti gli attributi di R**, cioè conoscendo i valori di K posso ricostruire l’intera tupla.  
- **K** è **[[Relational Model#Superchiave|superchiave]]**.

---

**Minimalità:**

Non esiste un **sottoinsieme proprio K'** di **K** tale che:

$$K' \to R \in F^+$$

Significa che **nessun attributo di K è ridondante**.  
- Se togli anche solo un attributo, K non determina più tutto R.  
- In questo caso, K è **[[Relational Model#Chiave candidata|chiave candidata]]** (cioè una superchiave minimale).
- Tutte le superchiavi singleton (che contengono esattamente un elemento) sono minimali.

---
#### Identificare le chiavi di uno schema:

Si utilizza il [[Functional Dependencies#Calcolo di X<sup>+</sup>|calcolo]] della chiusura di un insieme di attributi per determinare le chiavi di uno schema **R** su cui è definito un insieme di dipendenze funzionali **F**:

---

**Procedimento:**

Dati uno schema **R** e un insieme di dipendenze funzionali **F**:

Scelta dei candidati:

- Per ogni **determinante** tra le dipendenze in **F**, forma un candidato iniziale.
- Aggiungi ad **ogni** candidato gli attributi in **R** che non compaiono mai come **determinati** tra le dipendenze in **F**.

> N.B. Dati:
> **X =** insieme generico di attributi in **R**.
> **A =** attributo di **R** che non compare mai come determinato in **F**.
> Se **X** non contiene **A** allora <b>X<sup>+</sup></b> non potrà mai contenere **A** (perché **A** non è mai apparso come determinato in **F**), quindi <b>X<sup>+</sup>≠ R</b>. Dunque **qualsiasi** sottoinsieme privo di **A** non è main superchiave. Infatti gli attributi di **R** che non compaiono mai in **F** come determinati possono essere determinati solo per [[Functional Dependencies#Riflessività (reflexivity)|riflessività]] da loro stessi.

^ca98ec

Calcolo della **[[Functional Dependencies#CHIUSURA DI UN INSIEME DI ATTRIBUTI|chiusura]]**:

- Per ogni candidato **X**, calcola la sua chiusura <b>X<sup>+</sup></b> utilizzando l'**[[Functional Dependencies#Algoritmo|algoritmo]]**.
- Se <b>X<sup>+</sup></b> **= R** allora (**[[Functional Dependencies#CHIAVI|unicità]]** confermata): **X** è una **superchiave**.

Verifica della **[[Functional Dependencies#CHIAVI|minimalità]]**:

- Per ogni superchiave trovata, prova a togliere un attributo alla volta.   
- Per ogni **Y ⊂ X** con cardinalità **| X | - 1** calcola <b>Y<sup>+</sup></b> per verificare se **Y** è una superchiave.  
- Se nessun sottoinsieme **Y** con cardinalità **| X | - 1** determina tutto **R**, allora **X** è **chiave candidata**.
- Se per qualsiasi **Y** con cardinalità **| X | - 1**: <b>Y<sup>+</sup></b>**= R** verificare la minimalità per **Y**, come hai fatto per **X**.
- Tutti i sottoinsiemi minimali di **X** (oppure **X** se è già minimale) sono **chiavi candidate**.

> N.B. Un metodo alternativo per la fase di scelta dei candidati è il calcolo di **X = R − (W − V)** per ogni **V → W ∈ F**. Questo metodo è più sicuro e sistematico (utile se si implementa un algoritmo) ma allo stesso tempo richiede molti più calcoli (se si svolgono esercizi su carta è sconsigliato).


---

**Esempio:**

**R = ABCDEGH**
**F = { AB → D, G → A, G → B, H → E, H → G, D → H }**

Scelta dei candidati:

Parto dai determinanti in **F**: **AB, G, H, D**.
Cerco in **R** tutti gli attributi che non compaiono mai come determinati in **F**: solo **C**.
Aggiungo **C** a tutti i determinanti in **F** e trovo i candidati iniziali: **ABC, GC, HC, DC**.

Calcolo della chiusura per ogni candidato:

<b>ABC<sup>+</sup>= ABCDEGH = R</b> quindi **ABC** è una superchiave di **R**.

Verifico se **ABC** è minimale analizzando i suoi sottoinsiemi:

Analizzo solo **AC** e **BC** in quanto **AB** non contiene **C** e non potrà mai essere una superchiave di **R** (guarda la [[Functional Dependencies#^ca98ec|nota]]):

<b>AC<sup>+</sup>= AC</b> quindi **AC** non è una superchiave di **R**.
<b>BC<sup>+</sup>= BC</b> quindi **BC** non è una superchiave di **R**.

Tutti i sottoinsiemi (con cardinalità **| ABC | - 1**) di **ABC** non sono superchiavi dunque **ABC** è **chiave candidata** di **R**.

<b>GC<sup>+</sup>= ABCDEGH = R</b> quindi **GC** è una superchiave di **R**.

Verifico se **GC** è minimale analizzando i suoi sottoinsiemi:

Per ovvi motivi **G** e **C** da soli non possono essere superchiavi in quanto **G** non contiene **C** (guarda la [[Functional Dependencies#^ca98ec|nota]]) e **C** da solo non determina nulla se non se stesso (non appare in **F** come determinante).

Tutti i sottoinsiemi di **GC** non sono superchiavi dunque **GC** è **chiave candidata** di **R**.

Per **HC** e **DC** il procedimento è identico a quello di **GC**, quindi anche queste sono **chiavi candidata** di **R**. In conclusione, le chiavi candidate dello schema **R** sono:

**ABC, GC, HC e DC**.

---

### DIPENDENZE PARZIALI

Un attributo **A** dipende **parzialmente** da una chiave **K** se:
Esiste **X → A ∈** <b>F<sup>+</sup></b>, con **A ∉ X**, tale che:

- **A non è un attributo primo** (non appartiene a una **[[Relational Model#Chiave candidata|chiave candidata]]** di **R**)
- **X è un sottoinsieme proprio della chiave candidata K (X ⊂ K)**.

> N.B. Per far si che **X ⊂ K** la chiave **K** deve essere necessariamente una **[[Relational Model#Chiave composta (o concatenata)|chiave composta]]** (deve contenere almeno due attributi).

---

**Esempio:**

**R = Esame(Matricola, CodCorso, Cognome, Nome, Data, Voto)**

In questo schema l'unica chiave candidata è **K = (Matricola, CodCorso)**. 

Una dipendenza nota dello schema è:
Ad ogni **Matricola** corrisponde un solo **Cognome**: **Matricola → Cognome**. 

Analizzando questa dipendenza:
**Cognome (A)** non è un attributo primo: **Cognome ∉ K**.
**Matricola (X)** è un sottoinsieme proprio di **(Matricola, CodCorso)**: **Matricola ⊂ K**.

Quindi possiamo dire che **Cognome** dipende parzialmente dalla chiave **(Matricola, CodCorso)**, come conseguenza di **Matricola → Cognome**.

---
### DIPENDENZE TRANSITIVE

Un attributo **A** dipende **transitivamente** da una chiave **K** se:
Esistono **K → X ∈** <b>F<sup>+</sup></b> e **X → A ∈** <b>F<sup>+</sup></b>, con **A ∉ X**, tali che:

- **A non è un attributo primo** (non appartiene a una **[[Relational Model#Chiave candidata|chiave candidata]]** di **R**)
- **X NON coincide e NON è parte di una qualsiasi chiave candidata K** di **R** **(∀K ∈ R vale X ⊄ K e K - X ≠ Ø)**.

> Quindi **X** è un insieme di attributi o completamente separato o che presenta solo un'intersezione con **K** (**X** contiene sempre e comunque almeno un attributo diverso da tutti gli attributi di **K**)

Si chiama **dipendenza [[Functional Dependencies#Transitività (Transitivity)|transitiva]]** perché l’attributo determinato **A** non dipende direttamente da una chiave o superchiave, ma dipende **per passaggio** attraverso un altro insieme di attributi **X**. Dunque in simboli: se **K → X** e **X → A**, allora **K → A per transitività**.

---

**Esempio:**

**R = Studente(Matricola, CodFiscale, Comune, Provincia)**

In questo schema le chiavi candidate sono <b>K<sub>1</sub> = Matricola</b> <b>K<sub>2</sub> = CodFiscale</b>. 

Due dipendenze note dello schema sono:
Ad ogni **Matricola** corrisponde un solo **Comune** di nascita: **Matricola → Comune**.
Un **Comune** si trova in una sola **Provincia**: **Comune → Provincia**.

Analizziamo queste dipendenze:
**Matricola (<b>K<sub>1</sub></b>)** determina **Comune**. 
**Comune (X)** non è sottoinsieme ne di **Matricola** ne di **CodFiscale**, e non coincide con nessuna delle due chiavi: **X ⊄** <b>K<sub>1</sub></b>, **X ⊄** <b>K<sub>2</sub></b>, <b>K<sub>1</sub></b> **- X ≠ Ø** e <b>K<sub>2</sub></b> **- X ≠ Ø**.
**Provincia (A)** non è un attributo primo: **Provincia ∉** <b>K<sub>1</sub></b> e **Provincia ∉** <b>K<sub>2</sub></b>.

Quindi possiamo dire che **Provincia** dipende transitivamente dalla chiave **Matricola**, come conseguenza di **Matricola → Comune** e **Comune → Provincia**.

---
### INSIEMI EQUIVALENTI

Siano **F** e **G** due insiemi di dipendenze funzionali su uno schema di relazione **R**. Diciamo che **F** e **G** sono **equivalenti** (si scrive **F ≡ G**) se e solo se le loro [[Functional Dependencies#CHIUSURA SEMANTICA|chiusure]] coincidono, cioè:

$$F^{+} = G^{+}$$

> N.B. L’equivalenza non implica che **F** e **G** contengano esattamente le stesse dipendenze. Significa invece che, pur avendo insiemi diversi, generano lo stesso insieme di conseguenze logiche (stesse dipendenze implicate).

---
#### Lemma 2: 

Siano **F** e **G** due insiemi di dipendenze funzionali qualsiasi. 
Allora:

$$F \subseteq G^{+} \implies F^{+} \subseteq G^{+}$$

cioè:

> “Se ogni dipendenza di **F** è già implicata da **G** (cioè appartiene a <b>G<sup>+</sup></b>), allora tutto ciò che si può dedurre da **F** usando gli [[Functional Dependencies#ASSIOMI DI ARMSTRONG|assiomi di Armstrong]] (<b>F<sup>+</sup></b>) si può dedurre anche da **G**, perché <b>G<sup>+</sup></b> è chiuso rispetto a quegli stessi assiomi".

---
**Dimostrazione:**

Ogni dipendenza in **F** è derivabile da **G** mediante gli assiomi di Armstrong.
Infatti per il [[Functional Dependencies#CHIUSURA SINTATTICA|teorema]]: **<b>G<sup>+</sup></b>= <b>G<sup>A</sup></b>**, dunque se applico gli assiomi di Armstrong sulle dipendenze in **G** posso ottenere dipendenze in **F** in quanto per ipotesi: **F ⊆ <b>G<sup>+</sup></b>**.
Ovviamente, sempre per il [[Functional Dependencies#CHIUSURA SINTATTICA|teorema]]: **<b>F<sup>+</sup></b>= <b>F<sup>A</sup></b>** dunque posso ottenere dipendenze in <b>F<sup>+</sup></b> applicando gli assiomi di Armstrong ad **F**.
Dunque se **F** è derivabile da <b>G<sup>+</sup></b> mediante gli assiomi e <b>F<sup>+</sup></b> è derivabile da **F** mediante gli assiomi, allora <b>F<sup>+</sup></b> è derivabile da <b>G<sup>+</sup></b> mediante gli assiomi, ovvero **<b>F<sup>+</sup></b>⊆ <b>G<sup>+</sup></b>**:

$$G^{+} \xRightarrow {A} F\xRightarrow {A} F^{+}$$

---
### COPERTURA MINIMALE

Una **copertura minimale** è una versione “ridotta all’essenziale” di un insieme di dipendenze funzionali **F**. Si costruisce con un insieme **G** tale che:

- **G** è **[[Functional Dependencies#INSIEMI EQUIVALENTI|equivalente]]** a **F** (cioè implica esattamente le stesse dipendenze),
- **G** non contiene nessuna ridondanza né a destra (determinato), né a sinistra (determinante), né come dipendenza intera.

> In altre parole: è l’insieme più semplice possibile che conserva tutto il potere informativo di **F**. Possono esserci più coperture minimali per un dato insieme di dipendenze funzionali **F**.

---

Perché **G** sia una copertura minimale di **F**, per ogni **DF** in **G** devono valere tre proprietà:

- **Parte destra ridotta a singleton:** ^cb10f5

	- Ogni dipendenza funzionale in **G** ha a come determinato un solo attributo.
	- **Esempio:** invece di scrivere **A → BC**, si scrive **A → B** e **A → C** ([[Functional Dependencies#Decomposizione (Decomposition / Projectivity)|decomposizione]]).

- **Parte sinistra non ridondante:** ^2c0cc2

	- In ogni dipendenza **X → A**, nessun attributo di **X** è superfluo.
	- **Formalmente:** per nessuna dipendenza funzionale **X → A** in **G** esiste un sottoinsieme **X' ⊂ X** tale che **G ≡ G - {X → A} ∪ {X' → A}**, ovvero tale che **X' → A** sia già implicato da **G**.
	- **Esempio:** se ho **AB → C**, ma già **A → C** è implicato, allora **B** è ridondante e va tolto.

- **Dipendenza non ridondante:** ^f19a2d

	- Nessuna dipendenza di **G** è superflua o ridondante.
	- **Formalmente:** per nessuna dipendenza funzionale **X → A** in **G** vale **G ≡ G - {X → A}**.
	- Ogni dipendenza di **G** è indispensabile per mantenere l’equivalenza **G ≡ F**.

---
#### Calcolo della copertura minimale di F:

Per ogni insieme di dipendenze funzionali **F** esiste una copertura minimale, equivalente ad **F**, che può essere ottenuta **in tempo polinomiale** in tre passi:

1. Usando la regola della [[Functional Dependencies#Decomposizione (Decomposition / Projectivity)|decomposizione]], le parti destre delle dipendenze funzionali vengono ridotte a singleton. Quindi ogni dipendenza funzionale **X → Y** viene decomposta ricorsivamente fino a quando **|Y| = 1**  (il singolo attributo **A**). ([[Functional Dependencies#^cb10f5|...]])
2. Ogni dipendenza funzionale <b>A<sub>1</sub> A<sub>2</sub>... A<sub>i-1</sub> <b style="color: blueviolet;">A<sub>i</sub></b> A<sub>i+1</sub>... A<sub>n</sub> → A</b> in **F** tale che: **F ≡ F - { <b>A<sub>1</sub> A<sub>2</sub>... A<sub>i-1</sub> <b style="color: blueviolet;">A<sub>i</sub></b> A<sub>i+1</sub>... A<sub>n</sub> → A</b> } ∪ { <b>A<sub>1</sub> A<sub>2</sub>... A<sub>i-1</sub> A<sub>i+1</sub>... A<sub>n</sub> → A</b> }** viene sostituita da <b>A<sub>1</sub> A<sub>2</sub>... A<sub>i-1</sub> A<sub>i+1</sub>... A<sub>n</sub> → A</b>. Il processo viene ripetuto ricorsivamente su <b>A<sub>1</sub> A<sub>2</sub>... A<sub>i-1</sub> A<sub>i+1</sub>... A<sub>n</sub> → A</b> fino a quando la dipendenza non può essere più ridotta (cioè quando tutti gli attributi del determinante risultano non ridondanti). ([[Functional Dependencies#^2c0cc2|...]])
3. Ogni dipendenza funzionale **X → A** in **F** tale che **F ≡ F - {X → A}** viene eliminata, in quanto risulta ridondante. ([[Functional Dependencies#^f19a2d|...]])

---