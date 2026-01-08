**Collection** in Java è un'interfaccia **contenuta nel [[Packages|package]] `java.util`** che permette di **memorizzare, accedere e manipolare gruppi di oggetti attraverso strutture dati**.  
Collection estende l'interfaccia [[Iterable]] del package `java.lang` (tutte le collezioni sono iterabili). Collection **non include gli array**, ma li possono sostituire in modo più flessibile.

---
### FRAMEWORK COLLECTION (GERARCHIA)

Le varie strutture dati in Java sono classi rese disponibili mediante il [[Framework]] delle collezioni. 

```r
java.util.Collection (INTERFACCIA)
│
├── List (INTERFACCIA)
│   ├── ArrayList (CLASSE)
│   ├── LinkedList (CLASSE)
│   └── Vector (CLASSE)
│
├── Set (INTERFACCIA)
│   ├── HashSet (CLASSE)
│   ├── LinkedHashSet (CLASSE)
│   └── TreeSet (CLASSE)
│
└── Queue (INTERFACCIA)
    ├── PriorityQueue (CLASSE)
    └── LinkedList (CLASSE)
```

>⚠️ **Nota**: C’è anche `Map` (`HashMap`, `TreeMap`, `LinkedHashMap`), che non è figlia di `Collection` ma fa comunque parte del JCF.

---
### PRINCIPALI INTERFACCE

#### `List<E>`

Permette **elementi duplicati**
Ordine **basato sull’inserimento**
Accesso per **indice**

**Implementazioni comuni**:

- [[ArrayList]]: array dinamico veloce in lettura
- [[LinkedList]]: lista doppiamente collegata, veloce in inserimento/rimozione

```java
List<String> list = new ArrayList<>();
list.add("Java");
list.add("Python");
list.add("Java"); // preso
System.out.println(list); // [Java, Python, Java] (ordine garantito)
```

---
#### `Set<E>`

Non permette **duplicati**
Ordine **non garantito** (dipende dall’implementazione)

**Implementazioni comuni**:

- [[HashSet]]: ordine casuale, più veloce
- [[LinkedHashSet]]: mantiene l’**ordine di inserimento**
- [[TreeSet]]: ordina **in base al valore naturale o a un comparatore**

```java
Set<String> set = new HashSet<>();
set.add("Java");
set.add("Python");
set.add("Java"); // ignorato
System.out.println(set); // [Java, Python] (ordine non garantito)
```

---
#### `Queue<E>` e `Deque<E>`

Comportamento **FIFO**
`Deque` permette operazioni in testa e in coda (double-ended)

**Implementazioni comuni**:

- [[LinkedList]]: anche come coda
- [[PriorityQueue]]: ordine basato su priorità

```java
Queue<String> coda = new LinkedList<>();
coda.offer("Task1");
coda.offer("Task2");
System.out.println(coda.poll()); // Task1
```

---
#### `Map<K, V>` 

Associa **chiavi** a **valori**
Non permette chiavi duplicate
(non estende Collection)

**Implementazioni comuni**:

- [[HashMap]]: veloce, ordine casuale
- [[LinkedHashMap]]: ordine di inserimento
- [[TreeMap]]: ordinato per chiave

```java
Map<String, Integer> mappa = new HashMap<>();
mappa.put("Java", 1995);
mappa.put("Python", 1991);
System.out.println(mappa.get("Java")); // 1995
```

---
### METODI DI ITERAZIONE SULLE COLLECTION IN JAVA

#### For-each loop 

Una speciale [[for Instruction#^3e8bd6|tipologia di for]].

| Caratteristica              | Valore                        |
| --------------------------- | ----------------------------- |
| Tipo di iterazione          | Esterna                       |
| Accesso all'indice          | ❌                             |
| Modifica durante iterazione | ❌ ([[Exception\|eccezione]]) |
| Leggibilità                 | ✅ Alta                        |
| Uso più comune              | ✅ Sì                          |

---
#### Iterator

Un **`Iterator`** è **un oggetto** che ti permette di **scorrere sequenzialmente gli elementi di una Collection**, uno alla volta, **senza dover conoscere i dettagli interni** della struttura dati (es. lista, set, ecc.).

È definito dall’[[Classes#INTERFACCIA|interfaccia]]:

```java
public interface Iterator<E> {
    boolean hasNext();    // ci sono altri elementi?
    E next();             // restituisce il prossimo elemento
    void remove();        // rimuove l’ultimo elemento restituito
}
```

**Esempio:**

```java
Iterator<Tipo> it = collezione.iterator();
while (it.hasNext()) {
    Tipo elemento = it.next();
    // uso elemento
}
```

| Caratteristica              | Valore             |
| --------------------------- | ------------------ |
| Tipo di iterazione          | Esterna            |
| Accesso all'indice          | ❌                  |
| Modifica durante iterazione | ✅ (con `remove()`) |
| Leggibilità                 | Media              |
| Flessibilità                | ✅ Alta             |

**Esempio con rimozione**:

```java
Iterator<String> it = listaNomi.iterator();
while (it.hasNext()) {
    if (it.next().equals("Giulio")) {
        it.remove();  // safe
    }
}
```

---
#### ListIterator (solo per `List`)

```java
ListIterator<Tipo> it = lista.listIterator();
while (it.hasNext()) {
    Tipo elemento = it.next();
    // uso elemento
}
```

| Caratteristica              | Valore               |
| --------------------------- | -------------------- |
| Tipo di iterazione          | Esterna              |
| Direzione                   | ✅ Avanti/indietro    |
| Modifica durante iterazione | ✅ (set, add, remove) |

**Esempio con modifica**:

```java
ListIterator<String> it = listaNomi.listIterator();
while (it.hasNext()) {
    if (it.next().equals("Giulio")) {
        it.set("Andrea");
    }
}
```

---
#### For classico (solo con `List`)

Classico [[for Instruction]].

```java
for (int i = 0; i < lista.size(); i++) {
    Tipo elemento = lista.get(i);
    // uso elemento
}
```

|Caratteristica|Valore|
|---|---|
|Tipo di iterazione|Esterna|
|Accesso all'indice|✅|
|Modifica durante iterazione|⚠️ Possibile, ma attenzione|
|Solo per List|✅|

---

