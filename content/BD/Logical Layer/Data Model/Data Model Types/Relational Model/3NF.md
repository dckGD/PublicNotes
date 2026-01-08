La Terza Forma Normale garantisce che uno [[Relational Model#Schema|schema]] relazionale non presenti ridondanze evitabili mantenendo al tempo stesso tutte le [[Functional Dependencies|dipendenze funzionali]] rilevanti. Si basa sull’idea che ogni attributo non banale debba dipendere direttamente da una [[Relational Model#Chiave|chiave]] o essere esso stesso un attributo primo (parte di una chiave candidata). Questa condizione assicura una struttura più pulita e coerente della relazione. La **3NF** non è la forma più restrittiva che si può ottenere, ne esistono altre, tra cui la forma normale di Boyce-Codd (**BCNF**).

---
### DEFINIZIONE

Uno schema di relazione **R** è in **Terza Forma Normale (3NF)** rispetto ad un insieme di dipendenze funzionali **F** se:

$$\forall\, X \to A \in F^{+},\  A\notin X$$

**Almeno una** delle seguenti condizioni è vera:
**A è un attributo primo** (cioè appartiene a una **[[Relational Model#Chiave candidata|chiave candidata]]** di R).
**X è una [[Relational Model#Superchiave|superchiave]]** (contiene una chiave completa). 

> N.B. Per **A ∈ X** la dipendenza è banale (cioè per [[Functional Dependencies#Riflessività (reflexivity)|riflessività]]) e in questo caso lo schema **R** non può mai violare la **3NF**.

---
#### Teorema:

Siano **R** uno schema di relazione e **F** un insieme di dipendenze funzionali su **R**. Uno schema **R** è in **3NF** **se e solo** se non esistono né **[[Functional Dependencies#DIPENDENZE PARZIALI|dipendenze parziali]]** né **[[Functional Dependencies#DIPENDENZE TRANSITIVE|dipendenze transitive]]** su **R**.

---

**Dimostrazione:**

**1. Se R è in 3NF, allora non esistono né DF parziali né transitive su R (⇒):**

Assumiamo che **R** sia in **[[3NF#DEFINIZIONE|3NF]]**:
Se **A** è primo (parte di una chiave) allora viene a mancare la prima condizione (**A** non primo) per avere una dipendenza [[Functional Dependencies#DIPENDENZE PARZIALI|parziale]] o [[Functional Dependencies#DIPENDENZE TRANSITIVE|transitiva]]. 
Proviamo quindi a prendere **A** non primo, dunque per definizione di [[3NF#DEFINIZIONE|3NF]] deve valere la condizione: **X** è [[Relational Model#Superchiave|superchiave]]. 
Dunque per definizione di superchiave:
- Non può verificarsi **X ⊂ K**, in quanto **X** non può essere propriamente contenuta in nessuna [[Functional Dependencies#CHIAVI|chiave candidata]]. Quindi: nessuna dipendenza [[Functional Dependencies#DIPENDENZE PARZIALI|parziale]] è possibile.
- Non può verificarsi **K - X ≠ Ø ∀ K ∈ R**, in quanto se **X** una superchiave allora esiste almeno una chiave candidata **K** in **R** tale che **K ⊆ X** (ovvero **K ⊂ X** o **K = X**) dunque non è possibile che per tutte le chiavi valga la condizione **K - X ≠ Ø**. Quindi: nessuna dipendenza [[Functional Dependencies#DIPENDENZE TRANSITIVE|transitiva]] è possibile.
Teorema (parte solo se) dimostrato.

---

**2. Se non esistono né DF parziali né transitive su R, allora R è in 3NF (⇐):**

Assumiamo che non esistono ne dipendenze [[Functional Dependencies#DIPENDENZE PARZIALI|parziali]] ne [[Functional Dependencies#DIPENDENZE TRANSITIVE|transitive]]:
Supponiamo **per assurdo** che **R** non sia in **[[3NF#DEFINIZIONE|3NF]]**, in tal caso: **∀ X → A ∈ <b>F<sup>+</sup></b>** tale che:
- **A** non è primo.
- **X** non è una superchiave.
Poiché **X** non è una superchiave sono possibili due casi mutuamente esclusivi:
- **∀ K ∈ R vale X ⊄ K e K - X ≠ Ø**, in tal caso **X → A ∈ <b>F<sup>+</sup></b>** è [[Functional Dependencies#DIPENDENZE TRANSITIVE|transitiva]] (**contraddizione**).
- **∃ K ∈ R tale che X ⊂ K**, in tal caso **X → A ∈ <b>F<sup>+</sup></b>** è [[Functional Dependencies#DIPENDENZE PARZIALI|parziale]] (**contraddizione**).
In entrambi i casi si giunge ad una contraddizione, dunque il teorema (parte se) è dimostrato.

---
### ESEMPI

Vediamo alcuni esempi di analisi della forma di uno schema **R**:

---
#### Esempio 1:

**R = ABCD**
**F = {A → B, B → CD}**

**Determinazione delle chiavi:**

Notiamo subito come **A** sia una **[[Relational Model#Chiave|chiave]]** dello schema, in quanto:
Per [[Functional Dependencies#Riflessività (reflexivity)|riflessività]]: **A → A ∈** <b>F<sup>A</sup></b> (banale).
Per [[Functional Dependencies#Transitività (Transitivity)|transitività]]: Se **A → B** e **B → CD** allora **A → CD ∈** <b>F<sup>A</sup></b>.
Per [[Functional Dependencies#Unione (Union / Additivity)|unione]]: Se **A → A**, **A → B** e **A → CD** allora **A → ABCD ∈** <b>F<sup>A</sup></b>.
Dunque **A → R ∈** <b>F<sup>A</sup></b> e, dato che <b>F<sup>A</sup></b> **=** <b>F<sup>+</sup></b>: **A → R ∈** <b>F<sup>+</sup></b>.
Quindi **A** rispetta le [[Functional Dependencies#CHIAVI|condizioni]] per essere una [[Relational Model#Chiave candidata|chiave candidata]] di R.

**Controllo della 3NF:**

Valutiamo ora se **R** è in **3NF** rispetto a <b>F<sup>+</sup></b>, quindi, per ogni **DF** in <b>F<sup>+</sup></b>, bisogna verificare che almeno una delle due condizioni della [[3NF#DEFINIZIONE|definizione]] sia vera:
Iniziamo per comodità con la verifica su **F** per poi passare a <b>F<sup>+</sup></b>:

**A → B** rispetta la **3NF** in quanto **A** è superchiave.

**B → CD** non può essere verificata in questo modo in quanto, stando alla [[3NF#DEFINIZIONE|definizione]], il determinato (**CD**) deve essere singleton, dunque:
Per [[Functional Dependencies#Decomposizione (Decomposition / Projectivity)|decomposizione]]: Se **B → CD** allora **B → C** e **B → D ∈** <b>F<sup>A</sup></b> (e quindi **∈** <b>F<sup>+</sup></b>) .
Ora verifichiamo **B → C** e **B → D** (in <b>F<sup>+</sup></b>):
In entrambi i casi non viene rispettata la **3NF** in quanto **B** non è superchiave e ne **C** ne **D** sono attributi primi (non fanno parte della chiave **A**).

**Conclusione finale:**

Concludiamo affermando che lo schema **R** non è in **3NF** rispetto a **F**.

---
#### Esempio 2:

**R = ABCD**
**F = {AC → B, B → AD}**

**Determinazione delle chiavi:**

Per [[Functional Dependencies#Riflessività (reflexivity)|riflessività]]: **AC → AC ∈** <b>F<sup>A</sup></b> (banale).
Per [[Functional Dependencies#Transitività (Transitivity)|transitività]]: Se **AC → B** e **B → AD** allora **AC → AD ∈** <b>F<sup>A</sup></b>.
Per [[Functional Dependencies#Unione (Union / Additivity)|unione]]: Se **AC → AC**, **AC → B** e **AC → AD** allora **AC → ABCD ∈** <b>F<sup>A</sup></b>.
Dunque **AC → R ∈** <b>F<sup>A</sup></b> e, dato che <b>F<sup>A</sup></b> **=** <b>F<sup>+</sup></b>: **AC → R ∈** <b>F<sup>+</sup></b>.
Quindi **AC** rispetta le [[Functional Dependencies#CHIAVI|condizioni]] per essere una [[Relational Model#Chiave candidata|chiave candidata]] di R.

Per [[Functional Dependencies#Aumento (Augmentation)|aumento]]: Se **B → AD** allora **BC → ACD ∈** <b>F<sup>A</sup></b>.
Per [[Functional Dependencies#Riflessività (reflexivity)|riflessività]]: **BC → B ∈** <b>F<sup>A</sup></b> (banale).
Per [[Functional Dependencies#Unione (Union / Additivity)|unione]]: Se **BC → ACD** e **BC → B** allora **BC → ABCD ∈** <b>F<sup>A</sup></b>.
Dunque **BC → R ∈** <b>F<sup>A</sup></b> e, dato che <b>F<sup>A</sup></b> **=** <b>F<sup>+</sup></b>: **BC → R ∈** <b>F<sup>+</sup></b>.
Quindi **BC** rispetta le [[Functional Dependencies#CHIAVI|condizioni]] per essere una [[Relational Model#Chiave candidata|chiave candidata]] di R.

Aggiungiamo che **ABC**, che contiene le due chiavi candidate **AC** e **BC**, è una [[Relational Model#Superchiave|superchiave]] (non è minimale quindi non può essere [[Relational Model#Chiave candidata|chiave candidata]]).

**Controllo della 3NF:**

Valutiamo ora se **R** è in **3NF** rispetto a <b>F<sup>+</sup></b>, quindi, per ogni **DF** in <b>F<sup>+</sup></b>, bisogna verificare che almeno una delle due condizioni della [[3NF#DEFINIZIONE|definizione]] sia vera:
Iniziamo per comodità con la verifica su **F** per poi passare a <b>F<sup>+</sup></b>:

**AC → B** rispetta la **3NF** in quanto **AC** è superchiave.

**B → AD** non può essere verificata in questo modo in quanto, stando alla [[3NF#DEFINIZIONE|definizione]], il determinato (**AD**) deve essere singleton, dunque:
Per [[Functional Dependencies#Decomposizione (Decomposition / Projectivity)|decomposizione]]: Se **B → AD** allora **B → A** e **B → D ∈** <b>F<sup>A</sup></b> (e quindi **∈** <b>F<sup>+</sup></b>) .
Ora verifichiamo **B → A** e **B → D** (in <b>F<sup>+</sup></b>):
**B → A** rispetta la **3NF** in quanto, malgrado **B** non sia superchiave, **A** è attributo primo (fa parte della chiave **AC**).
**B → D** **non** rispetta la **3NF** in quanto, **B** non è superchiave e **D** non è attributo primo (non fa parte di nessuna delle due chiavi **AC** e **BC**).

**Conclusione finale:**

Concludiamo affermando che lo schema **R** non è in **3NF** rispetto a **F**.

---
#### Esempio 3:

**R = ABCD**
**F = {AB → CD, BC → A, D → AC}**

**Determinazione delle chiavi:**

Per [[Functional Dependencies#Riflessività (reflexivity)|riflessività]]: **AB → A ∈** <b>F<sup>A</sup></b> e **AB → B ∈** <b>F<sup>A</sup></b> (banali).
Per [[Functional Dependencies#Unione (Union / Additivity)|unione]]: Se **AB → A**, **AB → B** e **AB → CD** allora **AB → ABCD ∈** <b>F<sup>A</sup></b>.
Dunque **AB → R ∈** <b>F<sup>A</sup></b> e, dato che <b>F<sup>A</sup></b> **=** <b>F<sup>+</sup></b>: **AB → R ∈** <b>F<sup>+</sup></b>.
Quindi **AB** rispetta le [[Functional Dependencies#CHIAVI|condizioni]] per essere una [[Relational Model#Chiave candidata|chiave candidata]] di R.

Per [[Functional Dependencies#Aumento (Augmentation)|aumento]]: Se **BC → A** allora **BC → AB ∈** <b>F<sup>A</sup></b>.
Per [[Functional Dependencies#Transitività (Transitivity)|transitività]]: Se **BC → AB** e **AB → CD** allora **BC → CD ∈** <b>F<sup>A</sup></b>.
Per [[Functional Dependencies#Unione (Union / Additivity)|unione]]: Se **BC → AB** e **BC → CD** allora **BC → ABCD ∈** <b>F<sup>A</sup></b>.
Dunque **BC → R ∈** <b>F<sup>A</sup></b> e, dato che <b>F<sup>A</sup></b> **=** <b>F<sup>+</sup></b>: **BC → R ∈** <b>F<sup>+</sup></b>.
Quindi **BC** rispetta le [[Functional Dependencies#CHIAVI|condizioni]] per essere una [[Relational Model#Chiave candidata|chiave candidata]] di R.

Per [[Functional Dependencies#Aumento (Augmentation)|aumento]]: Se **D → AC** allora **BD → ABC ∈** <b>F<sup>A</sup></b>.
Per [[Functional Dependencies#Riflessività (reflexivity)|riflessività]]: **BD → D ∈** <b>F<sup>A</sup></b> (banale).
Per [[Functional Dependencies#Unione (Union / Additivity)|unione]]: Se **BD → D** e **BD → ABC** allora **BD → ABCD ∈** <b>F<sup>A</sup></b>.
Dunque **BD → R ∈** <b>F<sup>A</sup></b> e, dato che <b>F<sup>A</sup></b> **=** <b>F<sup>+</sup></b>: **BD → R ∈** <b>F<sup>+</sup></b>.
Quindi **BD** rispetta le [[Functional Dependencies#CHIAVI|condizioni]] per essere una [[Relational Model#Chiave candidata|chiave candidata]] di R.

**Controllo della 3NF:**

Valutiamo ora se **R** è in **3NF** rispetto a <b>F<sup>+</sup></b>, quindi, per ogni **DF** in <b>F<sup>+</sup></b>, bisogna verificare che almeno una delle due condizioni della [[3NF#DEFINIZIONE|definizione]] sia vera:
Iniziamo per comodità con la verifica su **F** per poi passare a <b>F<sup>+</sup></b>:

**AB → CD** non può essere verificata in questo modo in quanto, stando alla [[3NF#DEFINIZIONE|definizione]], il determinato (**CD**) deve essere singleton, dunque:
Per [[Functional Dependencies#Decomposizione (Decomposition / Projectivity)|decomposizione]]: Se **AB → CD** allora **AB → C** e **AB → D ∈** <b>F<sup>A</sup></b> (e quindi **∈** <b>F<sup>+</sup></b>) .
Ora verifichiamo **AB → C** e **AB → D** (in <b>F<sup>+</sup></b>):
**AB → C** rispetta la **3NF** in quanto **AB** è superchiave.
**AB → D** rispetta la **3NF** in quanto **AB** è superchiave.

**BC → A** rispetta la **3NF** in quanto **BC** è superchiave.

**D → AC** non può essere verificata in questo modo in quanto, stando alla [[3NF#DEFINIZIONE|definizione]], il determinato (**AC**) deve essere singleton, dunque:
Per [[Functional Dependencies#Decomposizione (Decomposition / Projectivity)|decomposizione]]: Se **D → AC** allora **D → A** e **D → C ∈** <b>F<sup>A</sup></b> (e quindi **∈** <b>F<sup>+</sup></b>) .
Ora verifichiamo **D → A** e **D → C** (in <b>F<sup>+</sup></b>):
**D → A** rispetta la **3NF** in quanto, malgrado **D** non sia superchiave, **A** è attributo primo (fa parte della chiave **AB**).
**D → C** rispetta la **3NF** in quanto, malgrado **D** non sia superchiave, **C** è attributo primo (fa parte della chiave **BC**).

**Conclusione finale:**

Implicitamente abbiamo verificato tutte le **DF** in <b>F<sup>+</sup></b> con membro destro (determinato) singleton. Concludiamo affermando che lo schema **R** è in **3NF** rispetto a **F**.

---





