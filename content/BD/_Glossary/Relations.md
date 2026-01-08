Una relazione tra insiemi è un sottoinsieme del loro prodotto cartesiano e descrive come elementi di domini diversi possono essere associati tra loro. Nel modello relazionale questo concetto costituisce la base teorica delle tabelle, dove ogni tupla rappresenta un’istanza della relazione e ogni attributo ne descrive una componente.

---
### DEFINIZIONE

Una **relazione R tra due (o +) [[Domain|domini]] A​ e B** è un qualsiasi **sottoinsieme** del [[Cartesian Product|prodotto cartesiano]]:

$$R⊆A×B$$

Quindi una relazione è un insieme di **coppie ordinate** che collegano elementi di **A** con elementi di **B**. Ad esempio:

$$A=\{1,2,3\}\ :\ insieme\ degli\ utenti\ (N)$$

$$B=\{Travis,\ Drizzy\}\ :\ insieme\ dei\ cantanti\ (Stringhe)$$

Definisco la relazione "un utente segue un cantante":

$$R=\{(1,Drizzy),(2,Travis),(3,Drizzy)\}$$

Qui:

$$R⊆A×B$$

Non tutte le coppie sono presenti, solo quelle che rappresentano la relazione vera (R è una relazione di grado 2 e cardinalità 3).

---
### PROPRIETA'

**Dominio della relazione**: 
Insieme degli elementi di **A** che compaiono almeno una volta in **R** (nell'esempio: tutto **A**).

**Codominio**: 
Insieme degli elementi verso cui le coppie di **R** possono puntare: l'insieme **B**.

**Immagine della relazione** (**range**): 
Gli elementi di **B** effettivamente collegati (nell'esempio: tutto **B**).

**Grado**: 
Numero di domini che partecipano alla relazione (nell'esempio: 2, ovvero **A** e **B**).

**Cardinalità della relazione**: 
Numero di elementi della relazione **R** (nell'esempio: 3, ovvero (1,Drizzy), (2,Travis), (3,Drizzy)).

---
### RAPPRESENTAZIONE TABELLARE

In un **[[Relational Model#^e685fe|DB relazionale]]** le relazioni sono rappresentate da tabelle. 

- le **righe** rappresentano **istanze concrete** (numero di righe = cardinalità della relazione).
- le **colonne** rappresentano **attributi** (numero di colonne = grado della relazione).

---