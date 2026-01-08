La classe `LinkedHashSet` è una **classe** che implementa l’interfaccia `Set` e rappresenta un insieme di elementi **unici** (non ammette duplicati), ma **mantiene l’ordine di inserimento**. Internamente utilizza una combinazione di **HashTable** e **doppia lista collegata** (_Linked List_), che permette di:
- conservare l’ordine in cui gli elementi sono stati aggiunti;
- mantenere operazioni veloci per aggiunta, rimozione e ricerca.

>**Package**: [[JDK Packages#**`java.util`**|java.util]].
>**Interfaccia di riferimento**: [[Collection#`Set<E>`|Set]] (che estende [[Collection]]).

---
### CARATTERISTICHE PRINCIPALI

**Ordine di inserimento**: gli elementi vengono iterati nell’ordine in cui sono stati aggiunti.
**Unicità**: non ammette duplicati.
**Prestazioni**: operazioni `add`, `remove`, `contains` generalmente in O(1) grazie alla hash table.
**Elemento null**: ammesso, ma solo uno.
**Non sincronizzato**: più veloce in single-thread, non [[Multithreading|thread-safe]].
**Uso tipico**: quando serve un insieme che mantenga sia la velocità di `HashSet` sia l’ordine prevedibile di iterazione.

---
### METODI PRINCIPALI

|Metodo|Descrizione|
|---|---|
|`add(E e)`|Aggiunge un elemento se non è già presente.|
|`remove(Object o)`|Rimuove l’elemento se presente.|
|`contains(Object o)`|Verifica se l’elemento è presente.|
|`size()`|Restituisce il numero di elementi.|
|`isEmpty()`|Verifica se è vuoto.|
|`clear()`|Rimuove tutti gli elementi.|
|`iterator()`|Restituisce un iteratore (rispetta ordine inserimento).|

---
### ESEMPIO

```java
import java.util.LinkedHashSet;

public class EsempioLinkedHashSet {
    public static void main(String[] args) {
        // Creazione di un LinkedHashSet di Stringhe
        LinkedHashSet<String> nomiSlime = new LinkedHashSet<>();

        // Aggiunta di elementi
        nomiSlime.add("Papa V");
        nomiSlime.add("Nerissima Serpe");
        nomiSlime.add("Fritu");
        nomiSlime.add("Shark");

        // Aggiunta di un duplicato (non verrà aggiunto)
        nomiSlime.add("Papa V");

        // Stampa (mantiene ordine di inserimento)
        System.out.println("LinkedHashSet: " + nomiSlime);

        // Verifica presenza
        System.out.println("C'è Papa V? " + nomi.contains("Papa V"));

        // Iterazione
        System.out.println("\nIterazione in ordine di inserimento:");
        for (String nome : nomiSlime) {
            System.out.println("- " + nome);
        }
    }
}
```

**Output possibile:**

```yaml
LinkedHashSet: [Papa V, Nerissima Serpe, Fritu, Shark]
C è Papa V? true

Iterazione in ordine di inserimento:
- Papa V
- Nerissima Serpe
- Fritu
- Shark
```

---