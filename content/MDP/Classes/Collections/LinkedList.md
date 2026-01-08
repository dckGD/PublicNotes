La classe `LinkedList` è una **classe** che implementa le interfacce `List`, `Deque` e `Queue`.  Rappresenta una **lista doppiamente collegata** in cui ogni elemento (nodo) mantiene un riferimento sia al nodo precedente che a quello successivo.  
A differenza di `ArrayList`, le operazioni di inserimento e rimozione sono molto efficienti in qualsiasi punto della lista, ma l’accesso casuale per indice è più lento.

>**Package**: [[JDK Packages#**`java.util`**|java.util]].
>**Interfacce di riferimento**: [[Collection#`List<E>`|List]], [[Collection#`Queue<E>` e `Deque<E>`|Queue e Deque]] (che estendono [[Collection]]).

---
### CARATTERISTICHE PRINCIPALI

**Struttura interna**: lista doppiamente collegata (doppio puntatore: nodo precedente e successivo).
**Ordine garantito**: mantiene l’ordine di inserimento.
**Accesso per indice**: tempo O(n), più lento rispetto a `ArrayList`.
**Inserimenti e rimozioni**: veloci in testa, in coda e in punti intermedi (non serve spostare elementi).
**Non sincronizzata**: non è [[Multithreading|thread-safe]].
**Elementi null**: ammessi.
**Implementa anche una coda**: può essere usata come `Queue` o `Deque` (lista doppia).

---
### METODI PRINCIPALI

|Metodo|Descrizione|
|---|---|
|`add(E e)`|Aggiunge in coda.|
|`addFirst(E e)`|Aggiunge in testa.|
|`addLast(E e)`|Aggiunge in coda (equivalente a `add(e)`).|
|`get(int index)`|Restituisce l’elemento all’indice indicato.|
|`getFirst()`|Restituisce il primo elemento.|
|`getLast()`|Restituisce l’ultimo elemento.|
|`set(int index, E e)`|Sostituisce l’elemento all’indice indicato.|
|`remove()`|Rimuove e restituisce il primo elemento.|
|`remove(int index)`|Rimuove l’elemento all’indice indicato.|
|`removeFirst()`|Rimuove il primo elemento.|
|`removeLast()`|Rimuove l’ultimo elemento.|
|`size()`|Restituisce il numero di elementi.|
|`isEmpty()`|Verifica se la lista è vuota.|
|`contains(Object o)`|Verifica se la lista contiene un elemento.|
|`clear()`|Rimuove tutti gli elementi.|
|`iterator()`|Restituisce un `Iterator` per iterare sulla lista.|
|`forEach(Consumer action)`|Esegue un’azione per ogni elemento.|

---
### ESEMPIO

```java
import java.util.LinkedList;

public class EsempioLinkedList {
    public static void main(String[] args) {
        // Creazione di una LinkedList di Stringhe
        LinkedList<String> listaSlime = new LinkedList<>();

        // Aggiunta di elementi
        listaSlime.add("Papa V");
        listaSlime.add("Nerissima Serpe");
        listaSlime.add("Fritu");

        // Inserimento in testa e in coda
        listaSlime.addFirst("Shark");
        listaSlime.addLast("Apparecchiato");

        // Stampa della lista
        System.out.println("Lista Slime: " + listaSlime);

        // Accesso al primo e ultimo elemento
        System.out.println("Primo elemento: " + listaSlime.getFirst());
        System.out.println("Ultimo elemento: " + listaSlime.getLast());

        // Modifica di un elemento
        listaSlime.set(2, "Luigi");

        // Rimozione di elementi
        listaSlime.remove("Fritu");
        listaSlime.removeFirst();
        listaSlime.removeLast();

        // Verifica presenza
        System.out.println("C'è Papa? " + listaSlime.contains("Papa V"));

        // Iterazione con for-each
        System.out.println("\nLista finale:");
        for (String slime : listaSlime) {
            System.out.println("- " + slime);
        }
    }
}

```

**Output possibile**:

```yaml
Lista slime: [Shark, Papa V, Nerissima Serpe, Fritu, Apparecchiato]
Primo elemento: Shark
Ultimo elemento: Apparecchiato
C è Papa? true

Lista finale:
- Papa V
- Luigi
- Nerissima Serpe
```

---