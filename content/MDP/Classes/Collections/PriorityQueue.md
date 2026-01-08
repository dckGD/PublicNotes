La classe `PriorityQueue` implementa l’interfaccia `Queue`. Una **`PriorityQueue`** è una coda che **ordina automaticamente** i suoi elementi in base a una priorità. Se non viene fornito un comparatore, usa l’**ordinamento naturale** degli elementi (cioè devono implementare `Comparable`). È **non ordinata** come un array ordinato, ma quando estrai, ottieni **sempre l’elemento con priorità più alta** (o più bassa, a seconda dell’ordinamento). Internamente è implementata come **heap binario**.

>**Package**: [[JDK Packages#**`java.util`**|java.util]].
>**Interfaccia di riferimento**: [[Collection#`Set<E>`|Set]] (che estende [[Collection]]).

---
### CARATTERISTICHE PRINCIPALI

**Ordinamento automatico**: mantiene la coda in ordine di priorità.
**Heap min per default**: l’elemento con valore più basso viene estratto per primo (per invertire, usare un comparatore personalizzato).
**Nessun ordine costante di iterazione**: l’iterazione può dare elementi in ordine arbitrario.
**Permette elementi duplicati**.
**Non permette `null`**.
**Thread-unsafe**: non [[Multithreading|sincronizzata]] (per versione sincronizzata, usare `PriorityBlockingQueue`).

---
### METODI PRINCIPALI

|Metodo|Descrizione|
|---|---|
|`boolean add(E e)`|Aggiunge un elemento rispettando l’ordinamento.|
|`boolean offer(E e)`|Come `add()`, ma non lancia eccezioni in caso di errore.|
|`E peek()`|Restituisce l’elemento con priorità più alta senza rimuoverlo.|
|`E poll()`|Restituisce e rimuove l’elemento con priorità più alta.|
|`boolean remove(Object o)`|Rimuove la prima occorrenza di un elemento.|
|`int size()`|Restituisce il numero di elementi nella coda.|
|`void clear()`|Svuota la coda.|
|`Iterator<E> iterator()`|Itera sugli elementi (ordine non garantito).|

---
### ESEMPIO

```java
import java.util.PriorityQueue;
import java.util.Comparator;

public class PriorityQueueExample {
    public static void main(String[] args) {
        // PriorityQueue con ordinamento naturale 
        // (numeri più piccoli hanno priorità maggiore)
        PriorityQueue<Integer> pq = new PriorityQueue<>();
        pq.add(5);
        pq.add(1);
        pq.add(3);

        System.out.println("Coda: " + pq);
		// Mostra il più piccolo (1)
        System.out.println("Peek: " + pq.peek()); 
        // Rimuove il più piccolo (1)
        System.out.println("Poll: " + pq.poll()); 
        System.out.println("Dopo poll: " + pq);

        // PriorityQueue con comparatore personalizzato 
        // (valori più grandi hanno priorità)
        PriorityQueue<Integer> maxPQ = new PriorityQueue<>(Comparator.reverseOrder());
        maxPQ.add(5);
        maxPQ.add(1);
        maxPQ.add(3);
		
		// Restituisce il più grande (5)
        System.out.println("Max-Heap Poll: " + maxPQ.poll()); 
    }
}
```

**Output possibile:**

```yaml
Coda: [1, 5, 3]
Peek: 1
Poll: 1
Dopo poll: [3, 5]
Max-Heap Poll: 5
```

---