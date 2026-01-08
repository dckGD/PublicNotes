La classe `HashSet` è una **classe** che implementa l’interfaccia `Set` e rappresenta una **collezione di elementi unici** (cioè non ammette duplicati). Gli elementi **non hanno un ordine garantito**: l’ordine di iterazione può essere diverso da quello di inserimento.  
Internamente utilizza una **tabella hash** (`HashMap` come struttura di supporto) per garantire operazioni veloci.

>**Package**: [[JDK Packages#**`java.util`**|java.util]].
>**Interfaccia di riferimento**: [[Collection#`Set<E>`|Set]] (che estende [[Collection]]).

---
### CARATTERISTICHE PRINCIPALI

**Unicità**: non permette elementi duplicati.
**Nessun ordine garantito**: l’ordine può sembrare casuale e può cambiare nel tempo.
**Implementazione con hash table**: operazioni `add`, `remove`, `contains` in media O(1).
**Elemento null**: ammesso **una sola volta**.
**Non sincronizzato**: più veloce in single-thread, ma non [[Multithreading|thread-safe]].
**Ridimensionamento automatico**: cresce in base al carico della tabella hash (load factor).    

---
### METODI PRINCIPALI

|Metodo|Descrizione|
|---|---|
|`add(E e)`|Aggiunge un elemento (se non presente).|
|`remove(Object o)`|Rimuove l’elemento indicato.|
|`contains(Object o)`|Verifica se è presente un elemento.|
|`size()`|Restituisce il numero di elementi.|
|`isEmpty()`|Verifica se l’insieme è vuoto.|
|`clear()`|Rimuove tutti gli elementi.|
|`iterator()`|Restituisce un `Iterator` per iterare.|
|`forEach(Consumer action)`|Esegue un’azione per ogni elemento.|

---
### ESEMPIO

```java
import java.util.HashSet;

public class EsempioHashSet {
    public static void main(String[] args) {
        // Creazione di un HashSet di Stringhe
        HashSet<String> slimeSet = new HashSet<>();

        // Aggiunta di elementi
        slimeSet.add("Papa V");
        slimeSet.add("Nerissima Serpe");
        slimeSet.add("Fritu");

        // Tentativo di inserire un duplicato
        slimeSet.add("Papa V");

        // Stampa dell'insieme (ordine non garantito)
        System.out.println("HashSet Slime: " + slimeSet);

        // Verifica presenza
        System.out.println("C'è Fritu? " + slimeSet.contains("Fritu"));

        // Rimozione di un elemento
        slimeSet.remove("Fritu");

        // Iterazione con for-each
        System.out.println("\nHashSet finale:");
        for (String slime : slimeSet) {
            System.out.println("- " + slime);
        }
    }
}
```

**Output possibile**:

```yaml
HashSet Slime: [Papa V, Nerissima Serpe, Fritu]
C è Fritu? true

HashSet finale:
- Papa V
- Nerissima Serpe
```

---