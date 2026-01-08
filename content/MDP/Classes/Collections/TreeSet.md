La classe `TreeSet` è una **classe** che implementa l’interfaccia `NavigableSet` (che estende `SortedSet`, a sua volta estende `Set`).  
Rappresenta un **insieme ordinato** di elementi **unici** (non ammette duplicati), in cui l’ordinamento è determinato:
- dall’**ordine naturale** degli elementi (definito dall’interfaccia `Comparable`), **oppure**
- da un **Comparator** fornito al momento della creazione.
Internamente utilizza un **albero rosso-nero** (Red-Black Tree), una struttura ad albero binario bilanciato.

>**Package**: [[JDK Packages#**`java.util`**|java.util]].
>**Interfaccia di riferimento**: [[Collection#`Set<E>`|Set]] (che estende [[Collection]]).

---
### CARATTERISTICHE PRINCIPALI

**Ordinato**: mantiene gli elementi in ordine crescente (o secondo un `Comparator` personalizzato).
**Unicità**: non ammette duplicati.
**Prestazioni**: operazioni `add`, `remove`, `contains` in O(log n) grazie all’albero bilanciato.
**Navigazione ordinata**: metodi come `first()`, `last()`, `higher()`, `lower()` per ottenere elementi in base all’ordine.
**Elemento null**: non ammesso (può causare `NullPointerException` se si tenta di inserirlo).
**Non sincronizzato**: più veloce in single-thread, non [[Multithreading|thread-safe]].

---
### METODI PRINCIPALI

|Metodo|Descrizione|
|---|---|
|`add(E e)`|Aggiunge un elemento mantenendo l’ordine.|
|`remove(Object o)`|Rimuove un elemento.|
|`contains(Object o)`|Verifica se l’elemento è presente.|
|`first()`|Restituisce il primo elemento (minimo).|
|`last()`|Restituisce l’ultimo elemento (massimo).|
|`higher(E e)`|Restituisce l’elemento strettamente maggiore di `e`.|
|`lower(E e)`|Restituisce l’elemento strettamente minore di `e`.|
|`size()`|Restituisce il numero di elementi.|
|`clear()`|Rimuove tutti gli elementi.|
|`iterator()`|Restituisce un iteratore.|

---
### ESEMPIO

```java
import java.util.TreeSet;

public class EsempioTreeSet {
    public static void main(String[] args) {
        // Creazione di un TreeSet di interi
        TreeSet<Integer> numeri = new TreeSet<>();

        // Aggiunta di elementi
        numeri.add(50);
        numeri.add(10);
        numeri.add(30);
        numeri.add(20);
        numeri.add(40);

        // Stampa ordinata automaticamente
        System.out.println("TreeSet: " + numeri);

        // Accesso a elementi specifici
        System.out.println("Primo elemento: " + numeri.first());
        System.out.println("Ultimo elemento: " + numeri.last());

        // Navigazione
        System.out.println("Maggiore di 25: " + numeri.higher(25));
        System.out.println("Minore di 25: " + numeri.lower(25));

        // Iterazione
        System.out.println("\nIterazione:");
        for (Integer num : numeri) {
            System.out.println("- " + num);
        }
    }
}
```

**Output possibile**:

```yaml
TreeSet: [10, 20, 30, 40, 50]
Primo elemento: 10
Ultimo elemento: 50
Maggiore di 25: 30
Minore di 25: 20

Iterazione:
- 10
- 20
- 30
- 40
- 50
```

---