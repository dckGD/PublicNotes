L’**algebra relazionale** è un **linguaggio [[Formal Language#LINGUAGGIO PROCEDURALE|procedurale]] [[Formal Language|formale]]** usato per **manipolare e interrogare relazioni (tabelle)** nei database [[Relational Model|relazionali]]. Descrive **come ottenere** i risultati a partire da relazioni esistenti, usando **operazioni matematiche su insiemi di tuple**.   

---

**Caratteristiche:**

- **Chiusa**: ogni operazione produce una relazione.
- **Componibile**: i risultati possono essere input per altre operazioni.
- **Deterministica**: stesse relazioni → stesso risultato.

---

Gli **operandi** sono le **relazioni** (tabelle) di partenza o il risultato di altre operazioni.  
Ogni operazione produce **una nuova relazione** ([[Functional Dependencies#CHIUSURA SEMANTICA|chiusura]] relazionale). Ogni relazione risultato deve mantenere l'**[[Database#Integrità (integrity)|integrità]]** propria dei database relazionali (ad esempio non deve contenere duplicati).

---
### OPERATORI:

#### PROIEZIONE (π)

Seleziona solo le colonne specificate.  

**Sintassi:** 

<b>π<sub>attributi</sub>(relazione)</b>

**Esempio:** 

<b>π<sub>Nome</sub>(studenti)</b>

![[projection.png]]
Oppure:

<b>π<sub>Nome, Facoltà</sub>(Studenti)</b>

![[projection 1.png]]

---

![](data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==)
#### SELEZIONE (σ)

Filtra solo le righe che soddisfano una condizione.  

**Sintassi:** 

<b>σ<sub>condizione</sub>(relazione)</b>

**Esempio:** 

<b>σ<sub>Facoltà='informatica'</sub>(Studenti)</b>

![[selection.png]]
Oppure:

<b>σ<sub>Nome='Andrea'∧Facoltà='Informatica'</sub>(Studenti)</b>

![[selection 1.png]]

---
#### UNIONE(∪)

Unisce tutti i dati di due relazioni.
> N.B. gli operandi devono essere **union compatibili** (ovvero che hanno lo stesso [[Relational Model#Schema|schema]]).  

**Sintassi:** 

**R ∪ S**

**Esempio:** 

**Studenti = Studenti in sede ∪ Studenti fuori sede**

![[union.png]]

---
#### DIFFERENZA (−)

Restituisce le tuple presenti in una relazione ma non nell’altra.  
> N.B. gli operandi devono essere **union compatibili** (ovvero che hanno lo stesso [[Relational Model#Schema|schema]]).  

**Sintassi:** 

**R − S**

**Esempio:** 

**Studenti di informatica in sede = Studenti di informatica - Studenti fuori sede**

![[difference.png]]

Oppure:

**Studenti fuori sede non di informatica = Studenti fuori sede - Studenti di informatica**

![[difference 1.png]]

---
#### INTERSEZIONE (∩)

Restituisce le tuple presenti in entrambe le relazioni.  
> N.B. gli operandi devono essere **union compatibili** (ovvero che hanno lo stesso [[Relational Model#Schema|schema]]).  

**Sintassi:** 

**R ∩ S**

**Esempio:**

**Studenti fuori sede di informatica = Studenti fuori sede ∩ Studenti di informatica**

![[intersection.png]]

---
#### PRODOTTO CARTESIANO (×)

Combina ogni tupla di R con ogni tupla di S.  

**Sintassi:**

**R × S**

**Esempio:**

**Studenti × Esami**

![[cartesian product.png]]

→ base per costruire le **join**.

---
#### JOIN NATURALE (⨝)

Combina tuple di due relazioni in base a una condizione di uguaglianza. 

**Sintassi:** 

<b>R ⨝<sub>condizione</sub>S</b>

**Esempio:**  

<b>Studenti ⨝<sub>Studenti.Matricola=Esami.Matricola</sub>Esami</b>
> Che equivale a scrivere: <b>σ<sub>Studenti.Matricola=Esami.Matricola</sub>(Studenti×Esami)</b>

![[natural join.png]]

→ unisce studenti e esami corrispondenti.

---
#### RIDENOMINAZIONE (ρ)

Serve a rinominare relazioni o attributi.  

**Sintassi:** 

<b>ρ<sub>vecchioNome←nuovoNome</sub>(relazione)</b>

**Esempio:**

<b>ρ<sub>Matricola←Studente</sub>(Esami)</b>
![[ridenomination.png]]
→ Utile per distinguere relazioni o attributi uguali in operazioni complesse.

---
### QUANTIFICATORI

Nel **calcolo relazionale** e nella **logica dei predicati**, i **quantificatori** servono per esprimere condizioni sulle tuple (righe) o sui valori.  

---

Sono due: **esistenziale (∃)** e **universale (∀)**:

| Quantificatore | Significato                                        | Traduzione logica                                |
| -------------- | -------------------------------------------------- | ------------------------------------------------ |
| **∃**          | Esiste almeno una tupla che soddisfa la condizione | “c’è almeno un elemento per cui P(x) è vero”     |
| **∀**          | Tutte le tuple soddisfano la condizione            | “per ogni elemento P(x) è vero”                  |
| **¬∃**         | Neanche una tupla soddisfa la condizione (nessuna) | "per ogni elemento P(x) non è vero"              |
| **¬∀**         | Non tutte le tuple soddisfano la condizione        | "c'è almeno un elemento per cui P(x) non è vero" |

---

**Ecco alcuni esempi:**
![[quantifiers.png]]

---
#### ALMENO UNA TUPLA (∃)

**Query:**

Studente che ha **almeno un esame** con `Voto ≥ 18`.

---

**Procedimento:**

1. Rinomino l'attributo `Esami.Matricola` in `Esami.Studente` per distinguerlo da `Studenti.Matricola`.
2. Seleziono in Esami solo le tuple con Voto ≥ 18.
3. Faccio un join per `Studenti.Matricola` - `Esami.Studente` tra Studenti e σ<sub>Voto≥18</sub>(Esami).
4. Del risultato del join proietto solo Matricola Nome e Cognome degli studenti.

---

**Soluzione:**
<b>π<sub>Matricola,Nome,Cognome</sub>(Studenti⨝<sub>Studenti.Matricola=Esami.Studente</sub>σ<sub>Voto≥18</sub>(ρ<sub>Matricola←Studente</sub>(Esami)))</b>
![[quantifiers ∃.png]]
![[quantifiers ∃ 1.png]]
> N.B La proiezione finale toglie automaticamente le tuple Matricola, Nome, Cognome duplicate, infatti, come gli altri operatori, lavora su insiemi.

---
#### NESSUNA TUPLA (¬∃)

**Query:**

Studente per cui **non esiste** alcun esame con `Voto ≥ 18`.  

---

**Procedimento:**

1. Rinomino l'attributo `Esami.Matricola` in `Esami.Studente` per distinguerlo da `Studenti.Matricola`.
2. Seleziono in Esami solo le tuple con Voto ≥ 18.
3. Faccio un join per `Studenti.Matricola` - `Esami.Studente` tra Studenti e σ<sub>Voto≥18</sub>(Esami).
4. Del risultato del join proietto solo Matricola Nome e Cognome degli studenti.
5. Sottraggo il risultato della proiezione all'insieme di tutti gli studenti (**tutti gli studenti - studenti che soddisfano ∃**).

---

**Soluzione:**

<b>Studenti−Studenti con almeno un esame ≥ 18</b> ([[#ALMENO UNA TUPLA (∃)|guarda sopra]])

![[quantifiers ¬∃.png]]
> N.B. Se lo studente non ha dato esami allora non ha voti ≥ 18.

---
#### TUTTE LE TUPLE (∀) 

**Query:**

Studente che **non ha alcun esame con** `Voto < 18` (tutti con voto ≥ 18).

---

**Procedimento:**

1. Rinomino l'attributo `Esami.Matricola` in `Esami.Studente` per distinguerlo da `Studenti.Matricola`.
2. Seleziono in Esami solo le tuple con Voto < 18.
3. Faccio un join per `Studenti.Matricola` - `Esami.Studente` tra Studenti e σ<sub>Voto<</>18</sub>(Esami).
4. Del risultato del join proietto solo Matricola Nome e Cognome degli studenti.
5. Sottraggo il risultato della proiezione all'insieme di tutti gli studenti (**tutti gli studenti - studenti che soddisfano ∃**).

---

**Soluzione:**

<b>Studenti−Studenti con almeno un esame <</> 18</b> ([[#NESSUNA TUPLA (¬∃)|come sopra]] ma con Voto < 18)

![[quantifiers ∀.png]]
> N.B. Se lo studente non ha dato esami allora non ha voti < 18. Se volessi trovare gli studenti con nessun voto < 18 e almeno un voto ≥ 18 allora dovrei fare: 
> <b>(Studenti − Studenti con almeno un esame <</> 18) ∩ Studenti con almeno un esame ≥ 18</b>.
> _Otterrei nell'esempio solo gli studenti 104 e 208._

---

