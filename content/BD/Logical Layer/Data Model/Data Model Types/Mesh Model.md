Il **modello reticolare** è un tipo di **modello dei dati** in cui le informazioni sono organizzate come una **rete di record collegati** da relazioni di tipo **molti-a-molti**.

---

**Esempio di struttura:**
![[mesh model.png]]

---

**Caratteristiche principali:**

I **dati** sono memorizzati in **record** (simili a righe di tabella).
Le **relazioni** tra record sono rappresentate da **puntatori** che creano una rete.
Ogni record può avere **più genitori e più figli**, a differenza del [[Hierarchical Model|modello gerarchico]] dove c’è una sola relazione padre-figlio.

---

**Vantaggi:**

Maggiore flessibilità rispetto al modello gerarchico.
Relazioni complesse rappresentabili direttamente.
Accesso rapido ai dati tramite puntatori.

**Svantaggi:**

Struttura complessa da progettare e mantenere.
Dipendenza forte dalla logica del programma applicativo.

---

**Esempio:**  

Un record _Studente_ può essere collegato a più _Corsi_, e ogni _Corso_ può avere più _Studenti_. Queste relazioni vengono rappresentate con collegamenti diretti, non tramite tabelle intermedie come nel modello relazionale.

---