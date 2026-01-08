[[Classes#Interfaccia|Interfaccia]] contenuta nel [[Packages|package]] `java.lang`.  
**Funzione:** Fornisce un meccanismo per iterare sequenzialmente sugli elementi di una collezione o di un insieme di dati, senza esporre la loro struttura interna.  
**Utilizzo tipico:** Base per il _for-each loop_ (`for (E e : collection)`) e per l’uso esplicito di un `Iterator`.

---
### CARATTERISTICHE PRINCIPALI

**Interfaccia radice delle collezioni iterate:** Tutte le classi che vogliono essere iterate (come `Collection`, `List`, `Set`, `Queue`) implementano `Iterable`.  
**Supporto al for-each:** Grazie a `iterator()`, permette l’uso del _for-each loop_ in modo semplice e leggibile.  
**Iterazione sicura:** L’iterazione avviene tramite un `Iterator`, che può prevenire problemi durante la modifica della collezione mentre la si scorre.  
**Metodi di utilità con Java 8+:** Include metodi `default` come `forEach` e `spliterator` per operazioni funzionali e parallele.

---
### METODI PRINCIPALI

|Metodo|Descrizione|
|---|---|
|`Iterator<T> iterator()`|Restituisce un iteratore sugli elementi.|
|`default void forEach(Consumer<? super T> action)`|Applica un’azione a ogni elemento della sequenza (Java 8+).|
|`default Spliterator<T> spliterator()`|Restituisce uno _spliterator_ per l’iterazione parallela o sequenziale (Java 8+).|
#### Metodo `iterator()`:

L’unico metodo **astratto obbligatorio** è:

```java
Iterator<T> iterator();
```

- Deve restituire un **oggetto `Iterator`** che conosce come scorrere la collezione.
- **`Iterator`** è un’altra interfaccia (package `java.util`) con tre metodi importanti:

```java
boolean hasNext(); // c'è un altro elemento?
T next();          // restituisce il prossimo elemento
void remove();     // rimuove l’elemento corrente (opzionale)
```

- `Iterable` dice _"questa classe può essere iterata"_ → definisce il metodo `iterator()`.
- `Iterator` è l’oggetto _che fa davvero l’iterazione_ → definisce `hasNext()`, `next()` e `remove()`.
#### DEFAULT METHODS

Dal Java 8, `Iterable` ha metodi con implementazione **di default**:

**`forEach(Consumer)`**: esegue un’azione per ogni elemento:

```java
lista.forEach(s -> System.out.println(s.toLowerCase()));
```

**`spliterator()`**: usato per operazioni parallele con Stream:

```java
Spliterator<String> spliterator = lista.spliterator();

while(spliterator.tryAdvance((elemento) -> {
	System.out.println(elemento);
})) {
```

---
### RELAZIONE CON COLLECTION

Tutte le interfacce principali di `java.util` **estendono `Iterable`**:

```r
Iterable
   └── Collection
        ├── List
        ├── Set
        └── Queue
```

Quindi:
- `ArrayList`, `HashSet`, `LinkedList`, `TreeSet`, ecc. sono **tutte Iterable**.
- Per questo puoi scrivere:

```java
List<String> lista = List.of("A", "B", "C");
for (String s : lista) {
    System.out.println(s);
}
```

Il `for-each` funziona **perché `List` estende `Collection` che estende `Iterable`**.

---
### ESEMPIO

```java
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class IteratorExample {
    public static void main(String[] args) {
        List<String> lista = new ArrayList<>();
        lista.add("Santana");
        lista.add("Money");
        lista.add("Gang");

        Iterator<String> it = lista.iterator();

        while (it.hasNext()) {
            String parola = it.next();
            System.out.println(parola);
        }
    }
}
/* Output: 
 * Sanatana
 * Money
 * Gang 
 * /
```

>`it` (iterator) è una sorta di cursore che viene spostato avanti nella collezione.

---