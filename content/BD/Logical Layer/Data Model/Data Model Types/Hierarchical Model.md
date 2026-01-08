Il **modello gerarchico** è un tipo di **modello dei dati** in cui le informazioni sono organizzate in una **struttura ad albero**.

---

**Esempio di struttura:**
![[hierarchical model.png]]

---

**Caratteristiche principali:**

Ogni **record** (nodo) ha **un solo genitore** ma può avere **più figli**.
La relazione è di tipo **uno-a-molti**.
I dati si accedono seguendo il percorso dall’origine (radice) ai nodi foglia.

---

**Vantaggi:**

Struttura chiara e semplice da comprendere.
Accesso ai dati rapido per relazioni predefinite.

**Svantaggi:**

Scarsa flessibilità: un record può avere un solo genitore.
Modificare la struttura richiede cambiamenti complessi.
Difficile rappresentare relazioni molti-a-molti.

---

**Esempio:**

```
Università  
├── Facoltà  
│    ├── Corso  
│    │    ├── Studente  
│    │    └── Esame
```

---