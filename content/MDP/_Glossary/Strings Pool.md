Il **pool di stringhe** è un'area speciale della memoria **[[Java Memory Model#^95837d|heap]]** in cui vengono conservate le stringhe letterali per evitare duplicati e risparmiare memoria.

Quando creiamo una stringa usando un **letterale** (senza `new`), Java verifica se la stringa esiste già nel pool:

- Se **esiste**, la nuova variabile punterà alla stessa istanza.
- Se **non esiste**, Java creerà una nuova stringa nel pool.

---