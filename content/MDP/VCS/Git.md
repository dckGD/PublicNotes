Git è un [[VCS#TIPOLOGIE DI VCS|DVCS]] che ti permette di:
**Tenere traccia della storia** dei tuoi file (chi ha cambiato cosa e quando).
**Lavorare in parallelo** su più funzionalità (rami/branch).
**Collaborare** facilmente con altri, condividendo e ricevendo modifiche.

---
### FILE E CARTELLE IN GIT

Gli elementi fondamentali di Git sono:
- **Blob**: in Git, un file (qualsiasi sequenza di byte) si chiama _blob_.
- **Tree**: una cartella (directory) si chiama _tree_. Una tree è una mappa che associa nomi (file o sottocartelle) ad altri blob o tree.

---
### SNAPSHOT

Un “snapshot” è semplicemente la tree principale che descrive tutta la struttura di file e cartelle in un determinato istante (una sorta di fotografia del progetto in quell'istante).  

Immagina questa struttura:

```scss
<root> (tree)
├── foo (tree)
│   └── bar.txt (blob, contenuto = "Coutinho")
└── baz.txt (blob, contenuto = "que te paso?")
```

La tree radice contiene:
- la sottocartella `foo` (che a sua volta contiene il blob `bar.txt`),
- e il file `baz.txt`.

---
### OPERAZIONI DI SALVATAGGIO: COMMIT

Un **commit** in Git è un oggetto che registra:

1. La **tree** (snapshot) dell’intero progetto in quel momento.
2. Il (o i) suo(i) **genitore(i)**, cioè i commit precedenti.
3. Informazioni di **metadati**: autore, data, messaggio.
#### Esempio:

**Modifichi** uno o più file nel tuo progetto.

**Aggiungi** i file al "set di preparazione" (staging area) con:
```c#
git add file1.txt
```

**Crei un commit** con:
```c#
git commit -m "Messaggio descrittivo"
```

**A questo punto Git crea:**

- Uno **[[Git#SNAPSHOT|snapshot]]** dell’intero progetto (ma salva solo i file cambiati come nuovi oggetti)
- Un oggetto **commit** che punta a quello snapshot e contiene: il tuo **messaggio**, la tua **identità**, la **data** del commit, il **link al commit precedente** (per salvare i commit cronologicamente).

**Esempio:**

```powershell
commit1 (id: a1b2c3)
│   └── snapshot: index.html, style.css
│
↓
commit2 (id: d4e5f6)
│   └── snapshot: index.html, style.css, script.js
│
↓
commit3 (id: g7h8i9)
    └── snapshot: index.html, style.css (modificato), script.js
```

---
#### Organizzazione dei commit

Git organizza i commit non come una semplice lista, ma come un **grafo aciclico diretto** (DAG). Ogni commit può avere uno o più genitori:

La **commit history:**

Può essere **lineare** (senza biforcazioni)

```markdown
o <-- o <-- o 
```
>(genitore <-- figlio)

Può presentare delle biforcazioni con la creazione di **branch** (ramificazioni):

```markdown
o <-- o <-- o <-- o
            ^
            |
            └─--- o <-- o
```
>Anche questo è un DAG: non ci sono cicli, e ogni commit ha al massimo un genitore.

Può presentare unificazioni dei vari branch con la creazione di **merge**:
```markdown
o <-- o <-- o <-- o <-- o
            ^           |
            |           v
            └─--- o <-- o
```
>Anche qui abbiamo un DAG: le frecce vanno sempre indietro (dal figlio al genitore) e non ho nessun ciclo: da un commit (`o`) non posso tornare allo stesso seguendo l'ordine delle frecce.

---
### ADDRESSING DEGLI OGGETTI IN GIT

Tutti gli oggetti (blob, tree, commit) sono memorizzati in Git con nome pari all’**hash SHA-1** del loro contenuto:

```csharp
id = sha1(contenuto_dell_oggetto)
```

Questo garantisce che lo stesso oggetto (stessi byte) abbia sempre lo stesso ID.
Permette di rilevare automaticamente duplicati e garantisce integrità (se il contenuto cambia, cambia l’hash).
#### Cos'è l’hash SHA-1 (Secure Hash Algorithm 1)

È una **funzione crittografica di hash** che:

- prende in input **qualunque dato** (un file, un messaggio, ecc.)
- produce in uscita una **stringa di 40 caratteri esadecimali** (160 bit)
- **identifica in modo univoco** quel contenuto

> Due contenuti diversi (anche con una sola virgola diversa) produrranno **hash completamente diversi**.
#### Reference

È scomodo ricordarsi i 40 caratteri dell’hash SHA-1. Per questo Git usa delle **reference** (puntatori automatici) che mappano nomi leggibili a hash:

- `master`, `main`, `develop`, `feature/x`, ecc. sono nomi di branch, cioè reference che “spuntano” a un commit.
- Una reference può essere automaticamente aggiornata per “spostarsi” lungo la storia (ad es. quando fai nuovi commit).

Specialmente importante è **HEAD**, che indica “dove siamo ora”. Quando crei un nuovo commit, Git sa chi mettere come genitore leggendo il commit a cui HEAD punta.

---
### REPOSITORY

Una **repository (o "repo") Git** è semplicemente una **cartella di progetto** che contiene al suo interno:

I **file del tuo progetto** (codice, testi, immagini, ecc.)
Una **sottocartella nascosta `.git/`**, che contiene **tutta la storia del progetto**.

Quella cartella `.git/` **è il cuore della repository Git**.  
Tutto quello che Git fa (salvataggio dei commit, branch, ecc.) avviene lì dentro.

---
### STAGING AREA 

Prima di creare un commit, Git ti permette di scegliere esattamente quali modifiche includere nel prossimo snapshot tramite la **staging area** (o “index”):

Modifichi file nel working directory.
Con `git add` porti le modifiche desiderate nell’index.
Con `git commit` crei il nuovo commit basato sull’index, non sull’intera directory.

Questo ti dà la flessibilità di suddividere il lavoro in più piccoli commit logici, anche se hai cambiato tante cose insieme.

---
### COMANDI FONDAMENTALI

`git init` – crea una nuova repository (.git).    
`git status` – mostra lo stato di working dir e index.
`git add <file>` – aggiunge file all’index.
`git commit` – crea un nuovo commit.
`git log` – mostra la storia dei commit.
`git diff` – confronta modifiche fra working dir, index, e commit.
`git branch` / `git checkout` / `git merge` – gestiscono rami e fusioni.
`git remote` / `git fetch` / `git pull` / `git push` – lavorano con repository remoti.

---