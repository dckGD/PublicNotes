Un **modello dei dati** (_data model_) è una rappresentazione astratta della struttura dei dati e delle relazioni fra essi, che serve a definire come i dati sono organizzati, memorizzati e utilizzati in un sistema informativo o in un database.

---
### A COSA SERVE

Un modello di dati ben strutturato è utile per:

- Fornire una **visione strutturata** delle [[Data vs Information|informazioni]] necessarie a un’organizzazione. 
- Supportare la progettazione di un [[Database]] o di un intero [[Information System|sistema informativo]].
- Migliorare la **coerenza**, l’**integrità** e la **manutenibilità** dei dati ([[Database#CARATTERISTICHE|caratteristiche]] di un DB).
- Facilitare la comunicazione tra utenti di business e tecnici.

---
### LIVELLI DI ASTRAZIONE

Si riferiscono a **come viene rappresentata la struttura dei dati durante la progettazione** del database:

- **Modello concettuale**: entità, relazioni e vincoli (es. diagramma ER).
- **Modello logico**: tabelle, attributi, chiavi e tipi di dato (indipendente dal DBMS).
- **Modello fisico**: implementazione concreta nel DBMS (file, indici, partizioni).

> Scopo: passare dalla **rappresentazione concettuale** alla **realizzazione fisica** del database.

---