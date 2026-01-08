L'organizzazione fisica dei database definisce come i record logici di una relazione vengono disposti fisicamente nei file su disco. Una buona disposizione mira a ridurre il numero di accessi ai blocchi e a favorire accessi sequenziali, migliorando così il tempo di risposta delle operazioni del [[DBMS|DBMS]]. L’obiettivo principale è quello di organizzare i file in modo da massimizzare gli accessi sequenziali ([[Block Access#Sequential Block Access (SBA)|SBA]]) e minimizzare quelli casuali ([[Block Access#Random Block Access (RBA)|RBA]]).
Esistono più metodi di organizzazione primaria dei file:

- File [[Heap File|heap]].
- File [[Sequential File|sequenziale]].
- File [[Random File|hash]].
- File [[Indexed Sequential File|sequenziale indicizzato]].

---
