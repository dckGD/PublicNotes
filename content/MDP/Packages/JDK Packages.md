In **Java**, alcuni package sono considerati **"speciali"** perché fanno parte del [[Language Core|core del linguaggio]] e vengono caricati automaticamente o forniscono funzionalità fondamentali.

> Sono package forniti di default dal [[JDK]] (Java Development Kit).

---
### PACKAGE IMPORTATI DI DEFAULT

Questi package non necessitano di `import` perché sono automaticamente disponibili in tutti i programmi Java:
#### **`java.lang`**

**Contiene classi fondamentali** come `String`, `Math`, `System`, `Thread`, e `Object` (la classe base da cui derivano tutte le classi Java).

**Tree:** https://docs.oracle.com/javase/8/docs/api/java/lang/package-tree.html

---
### PACKAGE STANDARD

Questi package **devono essere importati** con `import nome_package.*;` o con `import nome_package.Classe;`:
#### **`java.util`**

Include **collezioni di dati** (come `ArrayList`, `HashMap`, `HashSet`), utilità per la gestione di date (`Date`, `Calendar`), strumenti per la gestione delle stringhe e molto altro.

**Tree:** https://docs.oracle.com/javase/8/docs/api/java/util/package-tree.html

---
#### **`java.io`**

Gestisce l'**input/output**, ovvero la lettura e scrittura di file, flussi di dati, e gestione delle risorse di sistema.

**Tree:** https://docs.oracle.com/javase/8/docs/api/java/io/package-tree.html

**`java.nio`** → Alternativa più veloce a `java.io` per I/O bufferizzato.

**Tree:** https://docs.oracle.com/javase/8/docs/api/java/nio/package-tree.html

---
#### **`java.net`**

Fornisce classi per la **comunicazione di rete**, come la gestione di connessioni HTTP, socket, e URL.

**Tree:** https://docs.oracle.com/javase/8/docs/api/java/net/package-tree.html

---
#### **`java.time`** 

Gestisce le **date e ore** in modo più preciso ed efficiente, sostituendo la vecchia API di `java.util.Date` e `java.util.Calendar`.

**Tree:** https://docs.oracle.com/javase/8/docs/api/java/time/package-tree.html

---
#### **`java.sql`**

Fornisce classi per la **comunicazione con database** tramite JDBC (Java Database Connectivity).

**Tree:** https://docs.oracle.com/javase/8/docs/api/java/sql/package-tree.html

---
