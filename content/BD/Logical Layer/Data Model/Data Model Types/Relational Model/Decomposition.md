La decomposizione di uno schema di relazione è un processo fondamentale nella progettazione di basi di dati. L’obiettivo principale è ottenere schemi più semplici e coerenti, spesso in **Terza Forma Normale ([[3NF|3NF]])**, garantendo al tempo stesso due requisiti essenziali:

- **Preservare le dipendenze funzionali**: tutte le regole di integrità che valevano sullo schema originario devono continuare a valere.
- **Assicurare il join senza perdita**: ogni istanza legale dello schema originario deve poter essere ricostruita mediante join naturale, senza introdurre tuple spurie o informazioni estranee.

> La decomposizione viene tipicamente applicata quando lo schema non è già in 3NF, oppure per motivi di **efficienza degli accessi** (ridurre la dimensione delle tuple permette di caricarne di più in memoria e separare informazioni usate in contesti diversi migliora le prestazioni).

---
### DEFINIZIONE

Sia **R** uno schema di relazione. Una decomposizione di **R** è una famiglia <b>ρ = {R<sub>1</sub>, R<sub>2</sub>, ..., R<sub>k</sub>}</b> di sottoinsiemi di **R** che **ricopre** **R**, ovvero:

$$\bigcup_{i=1}^{k} R_i = R$$

> Se lo schema **R** è composto da un certo insieme di attributi, decomporlo significa definire dei sottoschemi che contengono ognuno un sottoinsieme degli attributi di **R**. I sottoschemi possono avere attributi in comune, e la loro unione deve necessariamente contenere tutti gli attributi di **R**.

---
### DECOMPOSIZIONI CHE PRESERVANO LE DIPENDENZE

Sia **R** uno schema di relazione. **F** un insieme di dipendenze funzionali su **R** e <b>ρ = {R<sub>1</sub>, R<sub>2</sub>, ..., R<sub>k</sub>}</b> decomposizione di **R**, diciamo che **ρ** preserva **R** se:

$$F\equiv\bigcup_{i=1}^{k} \pi_{R_i} (F)$$

dove:

$$\pi_{R_i}(F)=\{X \to Y \ |\ X \to Y \in F^{+} ∧ XY \subseteq R_i\}$$

> Ogni <b>π<sub>R<sub>i</sub></sub>(F)</b> è un insieme di **dipendenze funzionali** dato dalla [[Relational Algebra#PROIEZIONE (π)|proiezione]] dell’insieme di dipendenze funzionali **F** sul sottoschema <b>R<sub>i</sub></b>. Contiene solo le dipendenze di <b>F<sup>+</sup></b> che hanno tutti gli attributi (determinati e determinanti) in <b>R<sub>i</sub></b>.

---

**Verifica:** 

Verificare se una decomposizione preserva un insieme di dipendenze funzionali **F** richiede che venga verificata l’[[Functional Dependencies#INSIEMI EQUIVALENTI|equivalenza]] dei due insiemi di dipendenze funzionali **F** e <b>G=∪<sub>i=1</sub><sup>k</sup> π<sub>R<sub>i</sub></sub>(F)</b> e quindi che valga la doppia inclusione <b>F<sup>+</sup>⊆ G<sup>+</sup></b> e <b>G<sup>+</sup>⊆ F<sup>+</sup></b>. ^7af50e

---
#### Prima inclusione:

Dimostriamo che  <b>G<sup>+</sup>⊆ F<sup>+</sup></b>:

Per come è stato definito **G** in questo caso sarà sicuramente <b>G ⊆ F<sup>+</sup></b>, infatti:
<b>G=∪<sub>i=1</sub><sup>k</sup> π<sub>R<sub>i</sub></sub>(F)</b>, dove <b>π<sub>R<sub>i</sub></sub>(F) = </b>**{ X → Y | X → Y ∈ <b>F<sup>+</sup></b> ∧ XY ⊆ R<sub>i</sub> }** quindi ogni <b>π<sub>R<sub>i</sub></sub>(F)</b> che viene inclusa in **G** è per definizione una porzione di <b>F<sup>+</sup></b>.
Inoltre, per il [[Functional Dependencies#Lemma 2|lemma]]: <b>G ⊆ F<sup>+</sup></b> ⟹ <b>G<sup>+</sup>⊆ F<sup>+</sup></b>, inclusione verificata.

---
#### Seconda inclusione:

Dimostriamo che  <b>F<sup>+</sup>⊆ G<sup>+</sup></b>:

Dimostrare che <b>F ⊆ G<sup>+</sup></b> significa verificare che per ogni **X → Y ∈ F**, vale <b>Y ⊆ X<sup>+</sup><sub>G</sub></b>, infatti:
Se <b>Y ⊄ X<sup>+</sup><sub>G</sub></b> allora **X → Y ∉ <b>G<sup>A</sup></b>** per il [[Functional Dependencies#Lemma 1|lemma]] e quindi **X → Y ∉ <b>G<sup>+</sup></b>** per il [[Functional Dependencies#CHIUSURA SINTATTICA|teorema]].
Quindi basta verificare che anche una sola dipendenza in **F** non appartiene alla chiusura di **G** per poter affermare che l'equivalenza non sussiste. Per farlo si utilizza un semplice **algoritmo** iterativo:
##### Algoritmo verifica F ⊆ G<sup>+</sup>:

```r
begin
	success := true
	for every X → Y ∈ F do:
	begin
		calculate Z    # Z = chiusura di X rispetto a G
		if Y ⊄ Z then: success := false
	end
end
```

- **Input:** due insiemi **F** e **G** di dipendenze funzionali su uno schema **R** e la chiusura <b>X<sup>+</sup><sub>G</sub></b> dell'insieme di attributi **X** rispetto a **G** (**Z = <b>X<sup>+</sup><sub>G</sub></b>**).
- **Output:** la variabile booleana **success** (se **success = true** allora <b>F ⊆ G<sup>+</sup></b>).

---

Per il calcolo di <b>X<sup>+</sup><sub>G</sub></b> si potrebbe ricorrere all'[[Functional Dependencies#Algoritmo calcolo X<sup>+</sup>|algoritmo]] del calcolo della chiusura di un insieme di attributi, ma per farlo dovremmo prima calcolare **G**. 
Sappiamo però che per **definizione**: <b>G=∪<sub>i=1</sub><sup>k</sup> π<sub>R<sub>i</sub></sub>(F)</b>, dove <b>π<sub>R<sub>i</sub></sub>(F) = </b>**{ X → Y | X → Y ∈ <b>F<sup>+</sup></b> ∧ XY ⊆ R<sub>i</sub> }** Dunque per costruire **G** in modo diretto, dovremmo prima avere <b>F<sup>+</sup></b>. Ma il calcolo di <b>F<sup>+</sup></b> è noto per essere **esponenziale** nel numero di attributi, perché può generare un numero enorme di dipendenze funzionali implicate. Ricorriamo quindi a un algoritmo che ci permette di calcolare <b>X<sup>+</sup><sub>G</sub></b> a partire da **F**:
##### Algoritmo calcolo X<sup>+</sup><sub>G</sub>:

```r
begin
	Z := X
	S := Ø
	for i := 1 to k do: S := S ∪ [(Z ∩ Rᵢ)⁺ ∩ Rᵢ]
	while S ⊄ Z do:
	begin
		Z := Z ∪ S
		for i := 1 to k do: S := S ∪ [(Z ∩ Rᵢ)⁺ ∩ Rᵢ]
	end
end
```

- **Input:** uno schema **R**, un insieme **F** di dipendenze funzionali su **R**, una decomposizione <b>ρ = {R<sub>1</sub>, R<sub>2</sub>, ..., R<sub>k</sub>}</b> di **R**, un sottoinsieme **X** di **R**;
- **Output:** la chiusura <b>X<sup>+</sup><sub>G</sub></b> di **X** rispetto a <b>G=∪<sub>i=1</sub><sup>k</sup> π<sub>R<sub>i</sub></sub>(F)</b> (nella variabile **Z**).

---

**Idea di base:**

Invece di calcolare prima <b>F<sup>+</sup></b> e poi costruire **G** (operazione esponenziale), l’algoritmo simula direttamente la proiezione e l’applicazione delle dipendenze di **G** usando solo **F**. Il meccanismo è semplice: per ogni sottoschema <b>R<sub>i</sub></b>, si prende <b>Z ∩ R<sub>i</sub></b> (gli attributi di **Z** che stanno in <b>R<sub>i</sub></b>), si calcola la loro chiusura rispetto a **F**, e si aggiungono a **Z** solo gli attributi risultanti nella chiusura che appartengono a <b>R<sub>i</sub></b>.

---

**Inizializzazione:**

**Z** sarà la variabile che contiene <b>X<sup>+</sup><sub>G</sub></b>. 

```r
Z := X
```

All’inizio conosciamo solo che **X** determina se stesso (per [[Functional Dependencies#Riflessività (reflexivity)|riflessività]]), quindi **X ⊆** <b>X<sup>+</sup><sub>G</sub></b>.

```r
S := Ø
```

**S** è l'insieme temporaneo di attributi che si possono aggiungere a **Z** ad ogni ciclo (inizialmente vuoto).

---

**Ciclo di scelta iniziale degli attributi:**

```r
for i := 1 to k do: S := S ∪ [(Z ∩ Rᵢ)⁺ ∩ Rᵢ]
```

Per ogni sottoschema <b>R<sub>i</sub></b>:

- Prendi gli attributi già presenti in **Z** che appartengono a <b>R<sub>i</sub></b> : <b>Z ∩ R<sub>i</sub></b>
- Calcola la loro chiusura rispetto a **F** : <b>(Z ∩ R<sub>i</sub>)<sup>+</sup><sub>F</sub></b>
- Mantieni solo gli attributi della chiusura che stanno in <b>R<sub>i</sub></b> : <b>(Z ∩ R<sub>i</sub>)<sup>+</sup><sub>F</sub> ∩ R<sub>i</sub></b>
- Aggiungi a **S** gli attributi risultanti : <b>S ∪ [(Z ∩ R<sub>i</sub>)<sup>+</sup><sub>F</sub> ∩ R<sub>i</sub>]</b>

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
for i := 1 to k do: S := S ∪ [(Z ∩ Rᵢ)⁺ ∩ Rᵢ]
```

Ripetiamo il calcolo di **S** con il nuovo **Z**. Questo può produrre ulteriori attributi deducibili, che verranno aggiunti al prossimo ciclo.

Continuiamo finché **S** non aggiunge più nulla (cioè **S ⊆ Z**).

---
### DECOMPOSIZIONI CON JOIN SENZA PERDITA

Sia **R** uno schema di relazione. Una decomposizione <b>ρ = {R<sub>1</sub>, R<sub>2</sub>, ..., R<sub>k</sub>}</b> di **R** ha un [[Relational Algebra#JOIN NATURALE (⨝)|join]] senza perdita se per ogni istanza legale ***r*** di **R** si ha:

$$r = \pi_{R_1}(r)⨝\pi_{R_2}(r)⨝...⨝\pi_{R_k}(r)$$

> Ogni <b>π<sub>R<sub>i</sub></sub>(<i>r</i>)</b> è un insieme di **tuple** dato dalla [[Relational Algebra#PROIEZIONE (π)|proiezione]] dell’istanza ***r*** sul sottoschema <b>R<sub>i</sub></b>. Contiene solo le tuple di ***r*** che hanno tutti gli attributi in <b>R<sub>i</sub></b>.

---
##### Teorema sulle decomposizioni con lossless join 

Sia **R** uno schema di relazione e <b>ρ = {R<sub>1</sub>, R<sub>2</sub>, ..., R<sub>k</sub>}</b> una decomposizione di **R**. Per ogni istanza legale ***r*** di **R**, indicato con <b><i>m</i><sub>ρ</sub>(<i>r</i>)</b> **=** <b>π<sub>R<sub>1</sub></sub>(<i>r</i>)</b> **⨝** <b>π<sub>R<sub>2</sub></sub>(<i>r</i>)</b> **⨝** **...** **⨝** <b>π<sub>R<sub>k</sub></sub>(<i>r</i>)</b> si ha:

- ***r* ⊆** <b><i>m</i><sub>ρ</sub>(<i>r</i>)</b>
- <b>π<sub>R<sub>i</sub></sub>(<b><i>m</i><sub>ρ</sub>(<i>r</i>)</b>)</b> **=** <b>π<sub>R<sub>i</sub></sub>(<i>r</i>)</b>
- <b><i>m</i><sub>ρ</sub>(<b><i>m</i><sub>ρ</sub>(<i>r</i>)</b>)</b> **=** <b><i>m</i><sub>ρ</sub>(<i>r</i>)</b>

> <b><i>m</i><sub>ρ</sub>(<i>r</i>)</b> è il [[Relational Algebra#JOIN NATURALE (⨝)|join]] delle [[Relational Algebra#PROIEZIONE (π)|proiezioni]] di ***r*** sui sottoschemi <b>R<sub>i</sub></b>, cioè l'istanza di **R** ricostruita a partire dalla decomposizione **ρ**.

---

**Spiegazione:**

***r* ⊆** <b><i>m</i><sub>ρ</sub>(<i>r</i>)</b> : Ogni tupla di ***r*** compare anche in <b><i>m</i><sub>ρ</sub>(<i>r</i>)</b>. Il join delle proiezioni infatti non perde mai tuple originali (può solo aggiungerne di altre).

<b>π<sub>R<sub>i</sub></sub>(<b><i>m</i><sub>ρ</sub>(<i>r</i>)</b>)</b> **=** <b>π<sub>R<sub>i</sub></sub>(<i>r</i>)</b> : Se si prende il join <b><i>m</i><sub>ρ</sub>(<i>r</i>)</b> e lo si proietta su <b>R<sub>i</sub></b>, si ottieni esattamente la stessa proiezione che si aveva da ***r***. 

<b><i>m</i><sub>ρ</sub>(<b><i>m</i><sub>ρ</sub>(<i>r</i>)</b>)</b> **=** <b><i>m</i><sub>ρ</sub>(<i>r</i>)</b> : Se si prende l’istanza ricostruita <b><i>m</i><sub>ρ</sub>(<i>r</i>)</b> e si applica di nuovo la stessa operazione di decomposizione e join, si ottiene lo stesso risultato (idempotenza). Questo è importante perché assicura che la ricostruzione è stabile e non dipende da quante volte si applica l’operazione.

---
##### Algoritmo verifica join senza perdita:

```r
begin
	build r
	repeat
	begin
		for every X → Y ∈ F do:
		begin
			if ∃ t₁,t₂ ∈ r tali che t₁[X] = t₂[X] e t₁[Y] ≠ t₂[Y] then:
			begin
				for every Aⱼ in Y do:
				begin 
					if t₁[Aⱼ] = "aⱼ" then: t₂[Aⱼ] := t₁[Aⱼ]
					else: t₁[Aⱼ] := t₂[Aⱼ]
				end
			end
		end
	end
	until: r ha almeno una riga con tutte "aⱼ" || r non è cambiato
	
	if r ha almeno una riga con tutte "aⱼ" then: ρ ha un lossless join
	else: ρ non ha un lossless join
end
```

- **Input:** uno schema di relazione **R**, un insieme **F** di dipendenze funzionali su **R**, una decomposizione <b>ρ = {R<sub>1</sub>, R<sub>2</sub>, ..., R<sub>k</sub>}</b> di **R**.
- **Output:** decide se **ρ** ha un join senza perdita.

---

**Costruzione di *r* :**

```r
build r
```

La tabella ***r*** ha:
- **|R|** colonne ***j*** (una per ogni attributo di **R**)
- **|ρ|** righe ***i*** (una per ogni sottoschema <b>R<sub>i</sub></b>)

In ogni cella di ***r*** :
- Se l’attributo <b>A<sub><i>j</i></sub> ∈ R<sub>i</sub></b>, mette il simbolo <b>a<sub><i>j</i></sub></b>.
- Se l'attributo <b>A<sub><i>j</i></sub> ∉ R<sub>i</sub></b>, mette un simbolo distinto <b>b<sub><i>ij</i></sub></b>.

> N.B. Ogni riga di ***r*** rappresenta una proiezione <b>π<sub>R<sub>i</sub></sub>(<i>r</i>)</b> del join, definendo gli attributi di <b>R<sub>i</sub></b> con <b>a<sub><i>j</i></sub></b>, e gli attributi non in <b>R<sub>i</sub></b> con simboli diversi.

^d3547b

---

**Ciclo di propagazione:**

```r
repeat
	...
until: r ha almeno una riga con tutte "aⱼ" || r non è cambiato
```

Ciclo che termina se:
- ***r*** contiene almeno una riga con tutte <b>a<sub><i>j</i></sub></b> nei campi, oppure 
- ***r*** non è nell'ultima iterazione del ciclo (cioè si propagano nuove uguaglianze).

```r
for every X → Y ∈ F do:
begin
	if ∃ t₁,t₂ ∈ r tali che t₁[X] = t₂[X] e t₁[Y] ≠ t₂[Y] then:
	begin
		for every Aⱼ in Y do:
		begin 
			if t₁[Aⱼ] = "aⱼ" then: t₂[Aⱼ] := t₁[Aⱼ]
			else: t₁[Aⱼ] := t₂[Aⱼ]
		end
	end
end
```

Per ogni **X → Y ∈ F** :
- Se ∃ <b>t<sub>1</sub>, t<sub>2</sub></b> **∈** ***r*** tali che <b>t<sub>1</sub>[X] = t<sub>2</sub>[X]</b> e <b>t<sub>1</sub>[Y] ≠ t<sub>2</sub>[Y]</b> ([[Functional Dependencies#Condizione logica|definizione]] di dipendenza funzionale), allora:
	- Per ogni attributo <b>A<sub><i>j</i></sub></b> nell'insieme **Y** (determinato):
		- Se <b>t<sub>1</sub>[A<sub><i>j</i></sub>]</b> **=** <b>a<sub><i>j</i></sub></b> allora : <b>t<sub>2</sub>[A<sub><i>j</i></sub>]</b> acquisisce il valore di <b>t<sub>1</sub>[A<sub><i>j</i></sub>]</b> (ovvero <b>a<sub><i>j</i></sub></b>)
		- Se <b>t<sub>1</sub>[A<sub><i>j</i></sub>]</b> **≠** <b>a<sub><i>j</i></sub></b> (quindi <b>t<sub>1</sub>[A<sub><i>j</i></sub>]</b> **=** <b>b<sub><i>ij</i></sub></b>) allora : <b>t<sub>1</sub>[A<sub><i>j</i></sub>]</b> acquisisce il valore di <b>t<sub>2</sub>[A<sub><i>j</i></sub>]</b> (che potrebbe essere <b>a<sub><i>j</i></sub></b> o <b>b<sub><i>ij</i></sub></b>)

> N.B. In questo modo stiamo anche rendendo l'istanza ***r*** un'istanza **legale**. Infatti alla fine del ciclo avremo che per ogni <b>t<sub>1</sub>[X] = t<sub>2</sub>[X]</b> allora <b>t<sub>1</sub>[Y] = t<sub>2</sub>[Y]</b>.

---

**Verifica finale:**

```r
if r ha almeno una riga con tutte "aⱼ" then: ρ ha un lossless join
else: ρ non ha un lossless join
```

- **Se esiste una riga in *r* con tutti <b>a<sub><i>j</i></sub></b>** : significa che la decomposizione è **senza perdita di join**, perché quella riga rappresenta la tupla originale ricostruita senza ambiguità.
- **Se non esiste una riga in *r* con tutti <b>a<sub><i>j</i></sub></b>** : la decomposizione è **con perdita**, perché non si riesce a ricostruire le tuple originali senza generare simboli spuri.

---
##### Esempio:

**R = ABCD**
**F = { A → B, C → D, B → C }**
**ρ = { <b>R<sub>1</sub></b> = AB, <b>R<sub>2</sub></b> = BC, <b>R<sub>3</sub></b> = CD }**

Verificare se **ρ** è una decomposizione con join senza perdita.

---

**Costruzione della tabella *r*** :

Colonne: **A, B, C, D**
Righe: una per ciascun sottoschema <b>R<sub>1</sub></b>, <b>R<sub>2</sub></b>, <b>R<sub>3</sub></b>

Regola di riempimento:

- Se l’attributo <b>A<sub><i>j</i></sub> ∈ R<sub>i</sub></b>, metto <b>a<sub><i>j</i></sub></b>
- Altrimenti metto un simbolo distinto <b>b<sub><i>ij</i></sub></b>

Tabella iniziale:

| <b>R<sub>i</sub></b>                 | A                            | B                            | C                            | D                            |
| ------------------------------------ | ---------------------------- | ---------------------------- | ---------------------------- | ---------------------------- |
| <b>R<sub>1</sub></b> <sup>(AB)</sup> | <b>a<sub><i>A</i></sub></b>  | <b>a<sub><i>B</i></sub></b>  | <b>b<sub><i>1C</i></sub></b> | <b>b<sub><i>1D</i></sub></b> |
| <b>R<sub>2</sub></b> <sup>(BC)</sup> | <b>b<sub><i>2A</i></sub></b> | <b>a<sub><i>B</i></sub></b>  | <b>a<sub><i>C</i></sub></b>  | <b>b<sub><i>2D</i></sub></b> |
| <b>R<sub>3</sub></b> <sup>(CD)</sup> | <b>b<sub><i>3A</i></sub></b> | <b>b<sub><i>3B</i></sub></b> | <b>a<sub><i>C</i></sub></b>  | <b>a<sub><i>D</i></sub></b>  |

---

**Ciclo di propagazione con le FD di F:**

Applichiamo ripetutamente: per ogni **X → Y ∈ F**:
Se esistono due righe <b>t<sub>1</sub></b>, <b>t<sub>2</sub></b> tali che <b>t<sub>1</sub>[X]</b> **=** <b>t<sub>2</sub>[X]</b> e <b>t<sub>1</sub>[Y]</b> **≠** <b>t<sub>2</sub>[Y]</b>, allora si uniformano i simboli in **Y** (preferendo gli <b>a<sub><i>j</i></sub></b> quando presenti):

---

**A → B :**

Confronto tra <b>R<sub>1</sub></b> e <b>R<sub>2</sub></b>:
- Su **A**: <b>a<sub><i>A</i></sub></b> **≠** <b>b<sub><i>2A</i></sub></b> quindi **A → B** qui non si applica (<b>R<sub>1</sub>[A]</b> **≠** <b>R<sub>2</sub>[A]</b>).  

| <b>R<sub>i</sub></b>                 | A                                                | B                                                   | C                            | D                            |
| ------------------------------------ | ------------------------------------------------ | --------------------------------------------------- | ---------------------------- | ---------------------------- |
| <b>R<sub>1</sub></b> <sup>(AB)</sup> | <b style="color: red;">a<sub><i>A</i></sub></b>  | <b style="color: darkred;">a<sub><i>B</i></sub></b> | <b>b<sub><i>1C</i></sub></b> | <b>b<sub><i>1D</i></sub></b> |
| <b>R<sub>2</sub></b> <sup>(BC)</sup> | <b style="color: red;">b<sub><i>2A</i></sub></b> | <b style="color: darkred;">a<sub><i>B</i></sub></b> | <b>a<sub><i>C</i></sub></b>  | <b>b<sub><i>2D</i></sub></b> |
| <b>R<sub>3</sub></b> <sup>(CD)</sup> | <b>b<sub><i>3A</i></sub></b>                     | <b>b<sub><i>3B</i></sub></b>                        | <b>a<sub><i>C</i></sub></b>  | <b>a<sub><i>D</i></sub></b>  |

Confronto tra <b>R<sub>2</sub></b> e <b>R<sub>3</sub></b>:
- Su **A**: <b>b<sub><i>2A</i></sub></b> **≠** <b>b<sub><i>3A</i></sub></b> quindi **A → B** qui non si applica (<b>R<sub>2</sub>[A]</b> **≠** <b>R<sub>3</sub>[A]</b>).  

| <b>R<sub>i</sub></b>                 | A                                                | B                                                    | C                            | D                            |
| ------------------------------------ | ------------------------------------------------ | ---------------------------------------------------- | ---------------------------- | ---------------------------- |
| <b>R<sub>1</sub></b> <sup>(AB)</sup> | <b>a<sub><i>A</i></sub></b>                      | <b>a<sub><i>B</i></sub></b>                          | <b>b<sub><i>1C</i></sub></b> | <b>b<sub><i>1D</i></sub></b> |
| <b>R<sub>2</sub></b> <sup>(BC)</sup> | <b style="color: red;">b<sub><i>2A</i></sub></b> | <b style="color: darkred;">a<sub><i>B</i></sub></b>  | <b>a<sub><i>C</i></sub></b>  | <b>b<sub><i>2D</i></sub></b> |
| <b>R<sub>3</sub></b> <sup>(CD)</sup> | <b style="color: red;">b<sub><i>3A</i></sub></b> | <b style="color: darkred;">b<sub><i>3B</i></sub></b> | <b>a<sub><i>C</i></sub></b>  | <b>a<sub><i>D</i></sub></b>  |

Confronto tra <b>R<sub>1</sub></b> e <b>R<sub>3</sub></b>:
- Su **A**: <b>a<sub><i>A</i></sub></b> **≠** <b>b<sub><i>3A</i></sub></b> quindi **A → B** qui non si applica (<b>R<sub>1</sub>[A]</b> **≠** <b>R<sub>3</sub>[A]</b>). 

| <b>R<sub>i</sub></b>                 | A                                                | B                                                    | C                            | D                            |
| ------------------------------------ | ------------------------------------------------ | ---------------------------------------------------- | ---------------------------- | ---------------------------- |
| <b>R<sub>1</sub></b> <sup>(AB)</sup> | <b style="color: red;">a<sub><i>A</i></sub></b>  | <b style="color: darkred;">a<sub><i>B</i></sub></b>  | <b>b<sub><i>1C</i></sub></b> | <b>b<sub><i>1D</i></sub></b> |
| <b>R<sub>2</sub></b> <sup>(BC)</sup> | <b>b<sub><i>2A</i></sub></b>                     | <b>a<sub><i>B</i></sub></b>                          | <b>a<sub><i>C</i></sub></b>  | <b>b<sub><i>2D</i></sub></b> |
| <b>R<sub>3</sub></b> <sup>(CD)</sup> | <b style="color: red;">b<sub><i>3A</i></sub></b> | <b style="color: darkred;">b<sub><i>3B</i></sub></b> | <b>a<sub><i>C</i></sub></b>  | <b>a<sub><i>D</i></sub></b>  |

---

**B → C** : 

Confronto tra <b>R<sub>1</sub></b> e <b>R<sub>2</sub></b>:
- Su **B**: <b>a<sub><i>B</i></sub></b> **=** <b>a<sub><i>B</i></sub></b>.
- Su **C**: <b>b<sub><i>1C</i></sub></b> **≠** <b>a<sub><i>C</i></sub></b> quindi uniformo **C** mettendo <b>a<sub><i>C</i></sub></b> in <b>R<sub>1</sub></b>.

| <b>R<sub>i</sub></b>                 | A                            | B                                               | C                                                  | D                            |
| ------------------------------------ | ---------------------------- | ----------------------------------------------- | -------------------------------------------------- | ---------------------------- |
| <b>R<sub>1</sub></b> <sup>(AB)</sup> | <b>a<sub><i>A</i></sub></b>  | <b style="color: red;">a<sub><i>B</i></sub></b> | <b style="color: orange;">a<sub><i>C</i></sub></b> | <b>b<sub><i>1D</i></sub></b> |
| <b>R<sub>2</sub></b> <sup>(BC)</sup> | <b>b<sub><i>2A</i></sub></b> | <b style="color: red;">a<sub><i>B</i></sub></b> | <b style="color: red;">a<sub><i>C</i></sub></b>    | <b>b<sub><i>2D</i></sub></b> |
| <b>R<sub>3</sub></b> <sup>(CD)</sup> | <b>b<sub><i>3A</i></sub></b> | <b>b<sub><i>3B</i></sub></b>                    | <b>a<sub><i>C</i></sub></b>                        | <b>a<sub><i>D</i></sub></b>  |

Confronto tra <b>R<sub>2</sub></b> e <b>R<sub>3</sub></b>:
- Su **B**: <b>a<sub><i>B</i></sub></b> **≠** <b>b<sub><i>3B</i></sub></b> quindi **B → C** qui non si applica (<b>R<sub>2</sub>[B]</b> **≠** <b>R<sub>3</sub>[B]</b>). 

| <b>R<sub>i</sub></b>                 | A                            | B                                                | C                                                   | D                            |
| ------------------------------------ | ---------------------------- | ------------------------------------------------ | --------------------------------------------------- | ---------------------------- |
| <b>R<sub>1</sub></b> <sup>(AB)</sup> | <b>a<sub><i>A</i></sub></b>  | <b>a<sub><i>B</i></sub></b>                      | <b>a<sub><i>C</i></sub></b>                         | <b>b<sub><i>1D</i></sub></b> |
| <b>R<sub>2</sub></b> <sup>(BC)</sup> | <b>b<sub><i>2A</i></sub></b> | <b style="color: red;">a<sub><i>B</i></sub></b>  | <b style="color: darkred;">a<sub><i>C</i></sub></b> | <b>b<sub><i>2D</i></sub></b> |
| <b>R<sub>3</sub></b> <sup>(CD)</sup> | <b>b<sub><i>3A</i></sub></b> | <b style="color: red;">b<sub><i>3B</i></sub></b> | <b style="color: darkred;">a<sub><i>C</i></sub></b> | <b>a<sub><i>D</i></sub></b>  |

Confronto tra <b>R<sub>1</sub></b> e <b>R<sub>3</sub></b>:
- Su **B**: <b>a<sub><i>B</i></sub></b> **≠** <b>b<sub><i>3B</i></sub></b> quindi **B → C** qui non si applica (<b>R<sub>1</sub>[B]</b> **≠** <b>R<sub>3</sub>[B]</b>). 

| <b>R<sub>i</sub></b>                 | A                            | B                                                | C                                                   | D                            |
| ------------------------------------ | ---------------------------- | ------------------------------------------------ | --------------------------------------------------- | ---------------------------- |
| <b>R<sub>1</sub></b> <sup>(AB)</sup> | <b>a<sub><i>A</i></sub></b>  | <b style="color: red;">a<sub><i>B</i></sub></b>  | <b style="color: darkred;">a<sub><i>C</i></sub></b> | <b>b<sub><i>1D</i></sub></b> |
| <b>R<sub>2</sub></b> <sup>(BC)</sup> | <b>b<sub><i>2A</i></sub></b> | <b>a<sub><i>B</i></sub></b>                      | <b>a<sub><i>C</i></sub></b>                         | <b>b<sub><i>2D</i></sub></b> |
| <b>R<sub>3</sub></b> <sup>(CD)</sup> | <b>b<sub><i>3A</i></sub></b> | <b style="color: red;">b<sub><i>3B</i></sub></b> | <b style="color: darkred;">a<sub><i>C</i></sub></b> | <b>a<sub><i>D</i></sub></b>  |

---

**C → D** :

Confronto tra <b>R<sub>1</sub></b> e <b>R<sub>2</sub></b>:
- Su **C**: <b>a<sub><i>C</i></sub></b> **=** <b>a<sub><i>C</i></sub></b>.
- Su **D**: <b>b<sub><i>1D</i></sub></b> **≠** <b>b<sub><i>2D</i></sub></b> quindi uniformo **C** mettendo <b>b<sub><i>2D</i></sub></b> in <b>R<sub>1</sub></b>.

| <b>R<sub>i</sub></b>                 | A                            | B                            | C                                               | D                                                   |
| ------------------------------------ | ---------------------------- | ---------------------------- | ----------------------------------------------- | --------------------------------------------------- |
| <b>R<sub>1</sub></b> <sup>(AB)</sup> | <b>a<sub><i>A</i></sub></b>  | <b>a<sub><i>B</i></sub></b>  | <b style="color: red;">a<sub><i>C</i></sub></b> | <b style="color: orange;">b<sub><i>2D</i></sub></b> |
| <b>R<sub>2</sub></b> <sup>(BC)</sup> | <b>b<sub><i>2A</i></sub></b> | <b>a<sub><i>B</i></sub></b>  | <b style="color: red;">a<sub><i>C</i></sub></b> | <b style="color: red;">b<sub><i>2D</i></sub></b>    |
| <b>R<sub>3</sub></b> <sup>(CD)</sup> | <b>b<sub><i>3A</i></sub></b> | <b>b<sub><i>3B</i></sub></b> | <b>a<sub><i>C</i></sub></b>                     | <b>a<sub><i>D</i></sub></b>                         |

Confronto tra <b>R<sub>2</sub></b> e <b>R<sub>3</sub></b>:
- Su **C**: <b>a<sub><i>C</i></sub></b> **=** <b>a<sub><i>C</i></sub></b>.
- Su **D**: <b>b<sub><i>1D</i></sub></b> **≠** <b>a<sub><i>D</i></sub></b> quindi uniformo **C** mettendo <b>a<sub><i>C</i></sub></b> in <b>R<sub>2</sub></b>.

| <b>R<sub>i</sub></b>                 | A                            | B                            | C                                               | D                                                  |
| ------------------------------------ | ---------------------------- | ---------------------------- | ----------------------------------------------- | -------------------------------------------------- |
| <b>R<sub>1</sub></b> <sup>(AB)</sup> | <b>a<sub><i>A</i></sub></b>  | <b>a<sub><i>B</i></sub></b>  | <b>a<sub><i>C</i></sub></b>                     | <b>b<sub><i>1D</i></sub></b>                       |
| <b>R<sub>2</sub></b> <sup>(BC)</sup> | <b>b<sub><i>2A</i></sub></b> | <b>a<sub><i>B</i></sub></b>  | <b style="color: red;">a<sub><i>C</i></sub></b> | <b style="color: orange;">a<sub><i>D</i></sub></b> |
| <b>R<sub>3</sub></b> <sup>(CD)</sup> | <b>b<sub><i>3A</i></sub></b> | <b>b<sub><i>3B</i></sub></b> | <b style="color: red;">a<sub><i>C</i></sub></b> | <b style="color: red;">a<sub><i>D</i></sub></b>    |

Confronto tra <b>R<sub>1</sub></b> e <b>R<sub>3</sub></b>:
- Su **C**: <b>a<sub><i>C</i></sub></b> **=** <b>a<sub><i>C</i></sub></b>.
- Su **D**: <b>b<sub><i>1D</i></sub></b> **≠** <b>a<sub><i>D</i></sub></b> quindi uniformo **C** mettendo <b>a<sub><i>C</i></sub></b> in <b>R<sub>1</sub></b>.

| <b>R<sub>i</sub></b>                                     | A                            | B                            | C                                               | D                                                  |
| -------------------------------------------------------- | ---------------------------- | ---------------------------- | ----------------------------------------------- | -------------------------------------------------- |
| <b style="color: red;">R<sub>1</sub></b> <sup>(AB)</sup> | <b>a<sub><i>A</i></sub></b>  | <b>a<sub><i>B</i></sub></b>  | <b style="color: red;">a<sub><i>C</i></sub></b> | <b style="color: orange;">a<sub><i>D</i></sub></b> |
| <b>R<sub>2</sub></b> <sup>(BC)</sup>                     | <b>b<sub><i>2A</i></sub></b> | <b>a<sub><i>B</i></sub></b>  | <b>a<sub><i>C</i></sub></b>                     | <b>a<sub><i>D</i></sub></b>                        |
| <b>R<sub>3</sub></b> <sup>(CD)</sup>                     | <b>b<sub><i>3A</i></sub></b> | <b>b<sub><i>3B</i></sub></b> | <b style="color: red;">a<sub><i>C</i></sub></b> | <b style="color: red;">a<sub><i>D</i></sub></b>    |

---

**Condizione di terminazione e controllo:**

Il ciclo si ferma quando:

- La tabella non cambia più, oppure
- Appare una riga con tutti simboli <b>a<sub><i>j</i></sub></b>.

A questo punto, la riga <b>R<sub>1</sub></b> è già tutta in <b>a<sub><i>j</i></sub></b>, condizione sufficiente per concludere che la decomposizione **ρ = { <b>R<sub>1</sub></b> = AB, <b>R<sub>2</sub></b> = BC, <b>R<sub>3</sub></b> = CD }** è senza perdita. 

---
###### Teorema sulla validità dell'algoritmo verifica join senza perdita:

L’algoritmo verifica correttamente se una decomposizione **ρ** di **R** ha un join senza perdita.

---

**Dimostrazione:**

Occorre dimostrare che **ρ** ha un join senza perdita (<b><i>m</i><sub>ρ</sub>(<i>r</i>)</b> **= *r*** per ogni ***r*** legale) **se e solo se**, quando l’[[Decomposition#Algoritmo verifica join senza perdita|algoritmo]] termina, la tabella ***r*** ha una tupla con tutte <b>a<sub><i>j</i></sub></b>.

**Supponiamo per assurdo** che **ρ** abbia un join senza perdita (<b><i>m</i><sub>ρ</sub>(<i>r</i>)</b> **= *r***), ma che quando l’algoritmo termina la tabella ***r*** **non abbia nessuna riga con tutti** <b>a<sub><i>j</i></sub></b>.

L’algoritmo termina solo quando non ci sono più violazioni delle dipendenze funzionali di **F**. Quindi la tabella ***r*** che otteniamo alla fine è un’istanza legale di **R**, cioè soddisfa tutte le **FD**.

Durante l’algoritmo, i simboli <b>a<sub><i>j</i></sub></b> non vengono mai trasformati in simboli <b>b<sub><i>ij</i></sub></b> (per il funzionamento proprio dell'algoritmo). Ogni riga della tabella, fin dall’inizio, rappresenta la proiezione <b>π<sub>R<sub>i</sub></sub>(<i>r</i>)</b> e contiene i suoi <b>a<sub><i>j</i></sub></b> originali. Quindi, al termine, ciascuna proiezione mantiene ancora i suoi <b>a<sub><i>j</i></sub></b>.

Se ogni proiezione <b>π<sub>R<sub>i</sub></sub>(<i>r</i>)</b> contiene i suoi <b>a<sub><i>j</i></sub></b>, allora il join <b><i>m</i><sub>ρ</sub>(<i>r</i>)</b> deve contenere almeno una tupla con tutti i simboli <b>a<sub><i>j</i></sub></b>. Ma questa tupla con tutti <b>a<sub><i>j</i></sub></b> **non compare** nella tabella finale (per ipotesi).

**Contraddizione:** da un lato, l’ipotesi dice che <b><i>m</i><sub>ρ</sub>(<i>r</i>)</b> **= *r***. Dall’altro, abbiamo dedotto che <b><i>m</i><sub>ρ</sub>(<i>r</i>)</b> deve contenere una tupla con tutti <b>a<sub><i>j</i></sub></b>, che però non è presente in ***r***. Quindi <b><i>m</i><sub>ρ</sub>(<i>r</i>)</b> **≠ *r*** (se la decomposizione fosse davvero senza perdita, il join dovrebbe ricostruire esattamente ***r*** e non un'altra istanza).

---
### CALCOLO DELLA DECOMPOSIZIONE

Dato uno schema di relazione **R** e una [[Functional Dependencies#COPERTURA MINIMALE|copertura minimale]] **F** su **R** è sempre possibile calcolare in **tempo polinomiale** una decomposizione <b>ρ = {R<sub>1</sub>, R<sub>2</sub>, ..., R<sub>k</sub>}</b> di **R** tale che:

- per ogni ***i, i=1, ..., k*** : <b>R<sub>i</sub></b> è in [[3NF|3NF]].
- **ρ** preserva **F**.

Per il calcolo ci serviamo di un algoritmo:

---
##### Algoritmo calcolo ρ:

```r
begin
	S := Ø
	for every A ∈ R such that ∄ X → Y ∈ F | A ∈ X ∪ Y do: S := S ∪ A
	if S ≠ Ø then:
	begin
        R := R - S
        ρ := ρ ∪ S
    end
    if ∃ X → Y ∈ F | (X ∪ Y = R) then: ρ := ρ ∪ R
    else
    begin
        for every X → A ∈ F do: ρ := ρ ∪ (X ∪ A)
    end
end
```

- **Input:** uno schema **R**, una [[Functional Dependencies#COPERTURA MINIMALE|copertura minimale]] **F** su **R**.
- **Output:** una decomposizione **ρ** di **R** che preserva **F** e che per ogni ***i, i=1, ..., k*** : <b>R<sub>i</sub></b> è in **3NF**.

---

**Inizializzazione:**

```r
S := Ø
```

**S** è l'insieme temporaneo di attributi orfani, cioè che non sono coinvolti in nessuna **DF** di **F** (inizialmente vuoto).

---

**Raccolta degli attributi orfani:**

```r
for every A ∈ R such that ∄ X → Y ∈ F | A ∈ X ∪ Y do: S := S ∪ A
```

Scansiona ogni attributo **A** di **R** e verifica se non appare in nessuna dipendenza di **F** (né nel determinante **X** né nel determinato **Y**). Se l'attributo soddisfa tale condizione (è orfano) lo aggiunge a **S**.

---

**Separazione degli attributi orfani:**

```r
if S ≠ Ø then:
```

Se almeno un attributo di **R** è orfano:

```r
R := R - S
```

Rimuove gli attributi orfani da **R**.

```r
ρ := ρ ∪ S
```

Aggiunge **S** come nuova relazione (sottoschema di **R**) nella decomposizione. È una relazione contenente solo attributi orfani.

---

**Controllo di una dipendenza totale su R:**

```r
if ∃ X → Y ∈ F | (X ∪ Y = R) then: ρ := ρ ∪ R
```

Se esiste una **DF** in **F** il cui insieme di attributi (determinante **∪** determinato) copre esattamente tutti gli attributi attuali di **R**. Allora aggiunge lo schema **R** alla decomposizione. Questo copre tutte le **DF** e rispetta la **3NF** perché con [[Functional Dependencies#COPERTURA MINIMALE|copertura minimale]] e con determinanti appropriati, le [[3NF#DEFINIZIONE|violazioni]] sono evitate o rese ammissibili (attributi primi o dipendenze da chiave).

---

**Calcolo della decomposizione per DF minimali:**

```r
else
```

Se non esiste una **DF** totale su **R**:

```r
for every X → A ∈ F do: ρ := ρ ∪ (X ∪ A)
```

Per ogni dipendenza minimale con lato destro singolo **A** (come richiesto dalla [[Functional Dependencies#COPERTURA MINIMALE|copertura minimale]]) aggiunge una relazione (sottoschema di **R**) contenente gli attributi di **X** insieme all’attributo **A** (attributi della **DF**).

---

**Perché funziona:**

**Preservazione delle DF:** ogni dipendenza minimale **X → A** ha una relazione <b>R<sub>i</sub></b> **= XA** dove la dipendenza è naturalmente valida, quindi l’insieme **F** è preservato (o ricostruibile via chiusura).

**3NF assicurata:** con [[Functional Dependencies#COPERTURA MINIMALE|copertura minimale]] e relazioni <b>R<sub>i</sub></b> costruite come **XA**, gli attributi determinati sono o primi nelle rispettive relazioni o dipendono da chiavi candidate del loro schema, rispettando la definizione di [[3NF#DEFINIZIONE|3NF]]. Gli attributi orfani non creano violazioni perché non ci sono **DF** che li coinvolgono.

**Pulizia semantica:** separare gli orfani evita di introdurre attributi che non partecipano a vincoli nel mezzo di relazioni <b>R<sub>i</sub></b> governate da **DF**, riducendo ambiguità e facilitando la manutenzione.

---
##### Teorema sulla validità dell'algoritmo calcolo ρ:

L’algoritmo calcola correttamente <b>ρ = {R<sub>1</sub>, R<sub>2</sub>, ..., R<sub>k</sub>}</b> tale che:

- per ogni ***i, i=1, ..., k*** : <b>R<sub>i</sub></b> è in [[3NF|3NF]].
- **ρ** preserva **F**.

---

**Dimostrazione:**

Dimostriamo separatamente le due proprietà:

---

**1. ρ preserva F:**

Sia <b>G = ∪<sub>i=1</sub><sup>k</sup> π<sub>R<sub>i</sub></sub>(F)</b>, per verificare che **ρ** preserva **F** dobbiamo [[Decomposition#^7af50e|dimostrare]] che **F** e **G** siano due insiemi [[Functional Dependencies#INSIEMI EQUIVALENTI|equivalenti]]. 

Sappiamo che per ogni **X → A ∈ F** si ha **XA ∈ ρ**, infatti dall'[[Decomposition#Algoritmo calcolo ρ|algoritmo]] notiamo che **XA** è uno dei sottoschemi di **R**:

```r
for every X → A ∈ F do: ρ := ρ ∪ (X ∪ A)
```

Dunque, per [[Decomposition#DECOMPOSIZIONI CHE PRESERVANO LE DIPENDENZE|definizione]], **X → A ∈ G**, quindi <b>F ⊆ G</b>, e quindi <b>F<sup>+</sup> ⊆ G<sup>+</sup></b>.

> N.B. La chiusura è monotona (può solo crescere o restare uguale all'insieme di partenza): quindi se **G** contiene tutte le **DF** di **F** allora la sua chiusura <b>G<sup>+</sup></b> conterrà sicuramente tutte le **DF** in <b>F<sup>+</sup></b>.

^de0ac5

Inoltre, sempre per [[Decomposition#DECOMPOSIZIONI CHE PRESERVANO LE DIPENDENZE|definizione]], **G** è ottenuto proiettando **F** sui vari sottoschemi, quindi ogni **DF** in **G** proviene da <b>F<sup>+</sup></b>, dunque <b>G ⊆ F<sup>+</sup></b> e, per il [[Functional Dependencies#Lemma 2|lemma]]: <b>G<sup>+</sup>⊆ F<sup>+</sup></b>

Abbiamo dimostrato entrambe le inclusioni, dunque <b>F<sup>+</sup> = G<sup>+</sup></b>, **ρ preserva F**.

---

**2. Ogni <b>R<sub>i</sub></b> in ρ è in 3NF:**

Analizziamo i diversi casi che si possono presentare:

**Caso 1 (S ∈ ρ):**

```r
if S ≠ Ø then:
begin
    R := R - S
    ρ := ρ ∪ S 
end
```

**S** è l'insieme degli attributi orfani. Per definizione, se un attributo non è determinato da nessuno, l’unico modo per “coprirlo” è che faccia parte della chiave. Quindi in ogni relazione **S**, tutti gli attributi sono **primi** (appartengono alla [[Relational Model#Chiave|chiave]]). Dunque se **S ∈ ρ**, ogni attributo in **S** fa parte della chiave e quindi, banalmente, **S** è in **[[3NF#DEFINIZIONE|3NF]]**.

**Caso 2 (R ∈ ρ):**

```r
if ∃ X → Y ∈ F | (X ∪ Y = R) then: ρ := ρ ∪ R
```

Esiste una dipendenza funzionale **X → A ∈ F** che coinvolge tutti gli attributi di **R**. Poiché **F** è una [[Functional Dependencies#COPERTURA MINIMALE|copertura minimale]] (condizione necessaria affinché l'algoritmo funzioni) la dipendenza **X → A** è sicuramente della forma: **(R - A) → A** e quindi **R - A** è [[Functional Dependencies#CHIAVI|chiave]] nello schema **R**. 
Prendendo una qualsiasi **Y → B ∈ F** con **YB ⊆ R**:

- Se **B = A**, allora per **minimalità** **Y = R - A** in quanto non può esistere un sottoinsieme proprio della chiave candidata che determina **A**. Dunque **Y** è chiave candidata e la **DF** rispetta la **3NF**.
- Se **B ≠ A**, allora **B ∈ R - A**, ovvero **B** appartiene a una chiave candidata, dunque **B** è un attributo primo e per questo la **DF** rispetta la **3NF**.

Dunque anche in questo caso **ρ** è in **[[3NF#DEFINIZIONE|3NF]]**.

**Caso 3 (XA ∈ ρ):**

```r
else
begin
	for every X → A ∈ F do: ρ := ρ ∪ (X ∪ A)
end
```

Per ogni **DF** minimale **X → A ∈ F**, l’algoritmo costruisce il sottoschema **X ∪ A**. Poiché **F** è una [[Functional Dependencies#COPERTURA MINIMALE|copertura minimale]], non può esistere un sottoinsieme <b>X<sup>'</sup>⊆ X</b> tale che <b>X<sup>'</sup>→ A</b> dunque **X** è [[Functional Dependencies#CHIAVI|chiave]] nello schema **XA**.
Prendendo una qualsiasi **Y → B ∈ F** con **YB ⊆ R**:

- Se **B = A**, allora per **minimalità** **Y = X** in quanto non può esistere un sottoinsieme proprio della chiave candidata che determina **A**. Dunque **Y** è chiave candidata e la **DF** rispetta la **3NF**.
- Se **B ≠ A**, allora **B ∈ X**, ovvero **B** appartiene a una chiave candidata, dunque **B** è un attributo primo e per questo la **DF** rispetta la **3NF**.

Dunque anche in questo caso **ρ** è in **[[3NF#DEFINIZIONE|3NF]]**.

---
##### Teorema sul calcolo di ρ con lossless join:

Dato uno schema di relazione **R**, una [[Functional Dependencies#COPERTURA MINIMALE|copertura minimale]] **F** su **R** e una decomposizione **ρ** di **R** prodotta dall'[[Decomposition#Algoritmo calcolo ρ|algoritmo]] di decomposizione: La decomposizione **σ = ρ ∪ W**, dove **W** è una [[Functional Dependencies#CHIAVI|chiave]] per **R**, è tale che:

- per ogni ***i, i=1, ..., k*** : <b>R<sub>i</sub></b> è in [[3NF|3NF]].
- **σ** preserva **F**.
- **σ** ha un [[Decomposition#DECOMPOSIZIONI CON JOIN SENZA PERDITA|join senza perdita]].

---

**Dimostrazione:**

Dimostriamo separatamente le tre proprietà:

---

**1. σ preserva F:**

Sia <b>G<sup>'</sup>= ∪<sub>i=1</sub><sup>k</sup> π<sub>R<sub>i</sub></sub>(F)</b>, per verificare che **σ** preserva **F** dobbiamo [[Decomposition#^7af50e|dimostrare]] che **F** e <b>G<sup>'</sup></b> siano due insiemi [[Functional Dependencies#INSIEMI EQUIVALENTI|equivalenti]]. 

Poiché **ρ** preserva **F** (per il [[Decomposition#Teorema sulla validità dell'algoritmo calcolo ρ|teorema]]) anche **σ** preserva **F**. Infatti **σ = ρ ∪ W** quindi stiamo aggiungendo una nuova proiezione <b>π<sub>Z</sub>(F)</b> all'insieme **G** : <b>G<sup>'</sup>= G ∪ π<sub>Z</sub>(F)</b>. Dunque <b>F ⊆ G ⊆ G<sup>'</sup></b>e quindi per la [[Decomposition#^de0ac5|monotonia]] della chiusura vale: <b>F<sup>+</sup> ⊆ G<sup>+</sup> ⊆ G<sup>'+</sup> </b>.

Inoltre, per [[Decomposition#DECOMPOSIZIONI CHE PRESERVANO LE DIPENDENZE|definizione]], <b>G<sup>'</sup></b> è ottenuto proiettando **F** sui vari sottoschemi, quindi ogni **DF** in <b>G<sup>'</sup></b> proviene da <b>F<sup>+</sup></b>, dunque <b>G<sup>'</sup>⊆ F<sup>+</sup></b> e, per il [[Functional Dependencies#Lemma 2|lemma]]: <b>G<sup>'+</sup>⊆ F<sup>+</sup></b>

Abbiamo dimostrato entrambe le inclusioni, dunque <b>F<sup>+</sup> = G<sup>'+</sup></b>, **σ preserva F**.

---

**2. Ogni <b>R<sub>i</sub></b> in σ è in 3NF:**

Poiché ogni schema di relazione in **ρ** è in **[[3NF#DEFINIZIONE|3NF]]** (per il [[Decomposition#Teorema sulla validità dell'algoritmo calcolo ρ|teorema]]) e **σ = ρ ∪ W**, è sufficiente verificare che anche lo schema di relazione **Z** sia in **3NF** per poter affermare che ogni schema di relazione in **σ** sia in è in **3NF**.

Supponiamo per assurdo che **W** non sia una chiave per lo schema **Z** (sappiamo che è impossibile in quanto, per [[Functional Dependencies#Riflessività (reflexivity)|riflessività]],  **W → W** vale sempre). Allora esiste un sottoinsieme <b>W<sup>'</sup></b> di **W** che determina tutto lo schema **W**, ovvero tale che <b>W<sup>'</sup>→ W ∈ F<sup>+</sup></b>. Poiché **W** è [[Functional Dependencies#CHIAVI|chiave]] per lo schema **R**, ovvero <b>W → R ∈ F<sup>+</sup></b>, pertanto, per [[Functional Dependencies#Transitività (Transitivity)|transitività]] abbiamo <b>W<sup>'</sup>→ R ∈ F<sup>+</sup></b>, ma questo contraddice il fatto che **W** è chiave per lo schema **R** (verrebbe violato il principio di **minimalità**). Pertanto **W** è chiave per lo schema **Z** e quindi per ogni dipendenza funzionale <b>X → A ∈ F<sup>+</sup></b> con **XA ⊆ W**: **A** è **attributo primo** (appartiene alla chiave **W**).

---

**3. σ ha un join senza perdita:**

Sappiamo che **W** è una [[Functional Dependencies#CHIAVI|chiave]] per **R**, quindi <b>W<sup>+</sup>= R</b>. Utilizzando quindi l'[[Functional Dependencies#Calcolo di X<sup>+</sup>|algoritmo]] per il calcolo della [[Functional Dependencies#CHIUSURA DI UN INSIEME DI ATTRIBUTI|chiusura]] su **W** possiamo determinare tutti gli attributi di **R - W** grazie alle dipendenze funzionali minime sullo schema **R**. L'algoritmo produce una lista ordinata di attributi determinati <b>A<sub>1</sub>, A<sub>2</sub>, ..., A<sub>n</sub></b> e, per ciascuno di essi, un determinante <b>Y<sub>i</sub> ⊆ Z<sub>i-1</sub></b> tale che <b>Y<sub>i</sub> → A<sub>i</sub> ∈ F</b>. Quindi l'algoritmo produrrà <b>Z<sub>0</sub> = W</b> e <b>Z<sub>i</sub>  = Z<sub>i-1</sub> ∪ A<sub>i</sub></b>.

Poiché **F** è una [[Functional Dependencies#COPERTURA MINIMALE|copertura minimale]], per ogni dipendenza <b>Y<sub>i</sub> → A<sub>i</sub></b> lo schema <b>Y<sub>i</sub>A<sub>i</sub></b> appartiene alla decomposizione **ρ**, e quindi anche a **σ**. 

Applicando alla decomposizione **σ** l'[[Decomposition#Algoritmo verifica join senza perdita|algoritmo]] di verifica del [[Decomposition#DECOMPOSIZIONI CON JOIN SENZA PERDITA|join senza perdita]], e utilizzando come insieme di dipendenze funzionali su **R**, l'insieme **F** di dipendenze <b>Y<sub>i</sub> → A<sub>i</sub></b> con cui abbiamo calcolato la chiusura <b>W<sup>+</sup></b>, possiamo dimostrare per induzione che **σ** ha un join senza perdita. 

Costruiamo la [[Decomposition#^d3547b|tabella r]] con una riga per ogni sottoschema di **σ**. In particolare:

- La riga di **W** ha inizialmente <b>a<sub><i>j</i></sub></b> su tutti gli attributi di **W**.
- La riga di ciascun sottoschema <b>Y<sub>i</sub>A<sub>i</sub></b> ha <b>a<sub><i>j</i></sub></b> su <b>Y<sub>i</sub></b> e, per propagazione, anche su <b>A<sub>i</sub></b>.

Consideriamo le dipendenze <b>Y<sub>1</sub> → A<sub>1</sub>, Y<sub>2</sub> → A<sub>2</sub>, ..., Y<sub>n</sub> → A<sub>n</sub></b> nell’ordine in cui gli attributi entrano nella chiusura di **W**. Dimostriamo per induzione che, dopo aver applicato la dipendenza <b>Y<sub>i</sub> → A<sub>i</sub></b>, la riga di **W** contiene <b>a<sub><i>j</i></sub></b> su tutti gli attributi <b>Z<sub>i</sub></b>.

> N.B. L'ordine delle dipendenze dato dal calcolo di <b>W<sup>+</sup></b> ci garantisce che nella [[Decomposition#^d3547b|tabella r]], al passo ***i***, la riga di **W** ha già <b>a<sub><i>j</i></sub></b> su <b>Y<sub>i</sub></b>, quindi la **DF** <b>Y<sub>i</sub> → A<sub>i</sub></b> è applicabile e possiamo propagare la <b>a<sub><i>j</i></sub></b> su <b>A<sub>i</sub></b>.

---

**Caso base (*i* = 1):**

$$Y_1⊆Z_0​=W$$

Quindi :

- La riga **W** ha già <b>a<sub><i>j</i></sub></b> su tutti i suoi attributi e quindi anche su <b>Y<sub>1</sub></b>.
- La riga <b>Y<sub>1</sub>A<sub>1</sub></b> ha <b>a<sub><i>j</i></sub></b> su <b>Y<sub>1</sub></b> e su <b>A<sub>1</sub></b>. 

Applicando la regola dell'[[Decomposition#Algoritmo verifica join senza perdita|algoritmo]] alla **DF** <b>Y<sub>1</sub> → A<sub>1</sub></b> propaghiamo la <b>a<sub><i>j</i></sub></b> di <b>A<sub>1</sub></b> (sulla riga di <b>Y<sub>1</sub></b>) pure sulla riga di **W**. Risultato: la riga di **W** ha <b>a<sub><i>j</i></sub></b> su tutti gli attributi di <b>Z<sub>1</sub> = W ∪ A<sub>1</sub></b>.

---

**Ipotesi induttiva:**

$$Y_{i+1}⊆Z_i​=Z_{i-1}\cup A_i $$

Si assume che per ogni ***i* > 1**, nella riga corrispondente a **W** nella [[Decomposition#^d3547b|tabella r]], ci sia una <b>a<sub><i>j</i></sub></b> in corrispondenza di ogni attributi <b>A<sub><i>j</i></sub></b> con ***j* ≤ *i* - 1** ([[Decomposition#DECOMPOSIZIONI CON JOIN SENZA PERDITA|lossless join]] sempre verificato).

---

**Passo induttivo (*i* > 1):**

Supponiamo valida l'ipotesi induttiva. Nella riga corrispondente a **W** nella tabella ***r*** ci sono già tutte le <b>a<sub><i>j</i></sub></b> sugli attributi di <b>Z<sub>i-1</sub></b>. Ora consideriamo l'attributo <b>A<sub>i</sub></b> che entra in chiusura grazie alla dipendenza funzionale minimale <b>Y<sub>i</sub> → A<sub>i</sub></b> con <b>Y<sub>i</sub> ⊆ Z<sub>i-1</sub></b>:

- La riga **W**, per ipotesi, ha già <b>a<sub><i>j</i></sub></b> su tutti gli attributi di <b>Z<sub>i-1</sub></b>, e quindi anche su <b>Y<sub>i</sub></b>.
- La riga <b>Y<sub>1</sub>A<sub>1</sub></b> ha <b>a<sub><i>j</i></sub></b> su <b>Y<sub>1</sub></b> e su <b>A<sub>1</sub></b>. 

Poiché le due righe concordano con <b>a<sub><i>j</i></sub></b> su <b>Y<sub>i</sub></b>, l’algoritmo di verifica del join senza perdita applica la **DF** <b>Y<sub>i</sub> → A<sub>i</sub></b> e **propaga la <b>a<sub><i>j</i></sub></b> su** <b>A<sub>i</sub></b> anche nella riga di **W**. 

Dunque La riga di **W** contiene ora <b>a<sub><i>j</i></sub></b> su tutti gli attributi di <b>Z<sub>i</sub> = Z<sub>i-1</sub> ∪ A<sub>1</sub></b>:

Ripetendo questo ragionamento per ogni ***i*=1, …, *n***, otteniamo che la riga di **W** si arricchisce progressivamente di tutte le <b>a<sub><i>j</i></sub></b> fino a coprire l’intero schema:

$$Z_n=R$$

Quindi, al termine, la tabella ***r*** contiene una riga tutta <b>a<sub><i>j</i></sub></b>, e per definizione dell’algoritmo la decomposizione **σ** ha un **join senza perdita**.

---