I **linguaggi per le basi di dati** servono a **definire**, **manipolare** e **controllare** i dati all’interno di un DBMS. Il principale è il linguaggio SQL (Structured Query Language), ma al suo interno si distinguono più categorie di linguaggi, ognuna con uno scopo preciso (linguaggio **[[Formal Language#LINGUAGGIO DICHIARATIVO|dichiarativo]] [[Formal Language|formale]]**). 

---
### SOTTOLINGUAGGI:

| Tipo di linguaggio | Scopo principale            | Esempi di comandi              |
| ------------------ | --------------------------- | ------------------------------ |
| **DDL**            | Definizione della struttura | CREATE, ALTER, DROP            |
| **DML**            | Manipolazione dei dati      | SELECT, INSERT, UPDATE, DELETE |
| **DCL**            | Controllo accessi           | GRANT, REVOKE                  |
| **TCL**            | Gestione transazioni        | COMMIT, ROLLBACK               |
| **QL**             | Interrogazione              | SELECT                         |

---
#### DDL – DATA DEFINITION LANGUAGE

Serve a **definire la struttura** del database.  
Operazioni: creare, modificare o eliminare tabelle, schemi e vincoli.  

---

**Comandi principali:**

`CREATE` – crea tabelle o oggetti.
`ALTER` – modifica la struttura.
`DROP` – elimina oggetti.    

---

**Esempio:**

```sql
CREATE TABLE Studenti (
  Matricola INT PRIMARY KEY,
  Nome VARCHAR(50),
  Corso VARCHAR(30)
);
```

---
#### DML – DATA MMANIPULATION LANGUAGE

Serve a **inserire, modificare, cancellare e interrogare** i dati.  

---

**Comandi principali:**

`SELECT` – interroga i dati.
`INSERT` – aggiunge record.
`UPDATE` – modifica record.
`DELETE` – elimina record.    

---

**Esempio:**

```sql
SELECT Nome, Corso FROM Studenti WHERE Corso = 'BD1';
```

---
#### DCL – DATA CONTROL LANGUAGE

Gestisce **autorizzazioni e sicurezza**.  

---

**Comandi principali:**

`GRANT` – concede permessi.
`REVOKE` – revoca permessi.    

---

**Esempio:**

```sql
GRANT SELECT ON Studenti TO Docente;
```

---
#### TCL – TRANSACTION CONTROLA LANGUAGE

Controlla le **transazioni** per garantire coerenza e integrità.  

---

**Comandi principali:**

`COMMIT` – conferma le modifiche.
`ROLLBACK` – annulla modifiche non confermate.
`SAVEPOINT` – crea punti di ripristino.    

---

**Esempio:**

```sql
BEGIN;
UPDATE Studenti SET Corso = 'BD1';
COMMIT;
```

---
#### 5. QL – QUERY LANGUAGE

Parte del DML, serve solo per **ricercare e visualizzare** dati (come `SELECT`).

---
