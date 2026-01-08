Un **sistema di controllo di versione** (in inglese **Version Control System**, o **VCS**) è un software che tiene traccia di tutte le modifiche effettuate a file e cartelle nel tempo. È fondamentale nello sviluppo software, ma si può usare ovunque sia utile avere una **cronologia delle modifiche**, come nella scrittura di documenti, nella gestione di configurazioni, o nella collaborazione su progetti.

---
### TIPOLOGIE DI VCS

**Centralizzati (CVCS)**: come **Subversion (SVN)** o **Perforce**

Tutto è gestito da un **server centrale**.
I client si collegano al server per ottenere file o inviare modifiche.
Se il server non funziona, l’intero sistema si blocca.

**Distribuiti (DVCS)**: come **[[Git]]**, **Mercurial**

Ogni sviluppatore ha una **copia completa del repository** (con tutta la cronologia).
Puoi lavorare offline e sincronizzarti con gli altri in un secondo momento.
È il modello usato da progetti come Linux, GitHub, GitLab, ecc.

---