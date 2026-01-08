La classe **`LinkedHashMap`** estende `HashMap` e implementa l’interfaccia `Map<K, V>`.  
È una mappa che mantiene **l’ordine di inserimento** degli elementi o, opzionalmente, l’ordine di accesso (per implementare una cache LRU).  
Internamente usa una tabella hash collegata a una lista doppia per mantenere l’ordine.

>**Package**: [[JDK Packages#**`java.util`**|java.util]].
>**Interfaccia di riferimento**: [[Collection#`Map<K, V>`|Map]] (che estende [[Collection]]).

---
### CARATTERISTICHE PRINCIPALI

**Mantiene ordine di inserimento**: durante l’iterazione gli elementi vengono restituiti nell’ordine in cui sono stati inseriti.
**Opzionale ordine di accesso**: può ordinare per accesso (default è ordine inserimento).
**Chiavi uniche**, come in `HashMap`.
Permette **una chiave `null`** e valori `null`.
**Non sincronizzato**, quindi non [[Multithreading|thread-safe]].
Performance simili a `HashMap` (operazioni in tempo costante medio O(1)).
Usato spesso quando serve iterare gli elementi in ordine prevedibile.

---
### METODI PRINCIPALI

| Metodo                                | Descrizione                                                     |
| ------------------------------------- | --------------------------------------------------------------- |
| `V put(K key, V value)`               | Inserisce o aggiorna la coppia chiave-valore.                   |
| `V get(Object key)`                   | Restituisce il valore associato a una chiave.                   |
| `V remove(Object key)`                | Rimuove la coppia associata a una chiave.                       |
| `boolean containsKey(Object key)`     | Verifica se una chiave è presente.                              |
| `boolean containsValue(Object value)` | Verifica se un valore è presente.                               |
| `int size()`                          | Numero di coppie nella mappa.                                   |
| `boolean isEmpty()`                   | Verifica se la mappa è vuota.                                   |
| `void clear()`                        | Rimuove tutte le coppie.                                        |
| `Set<K> keySet()`                     | Restituisce un set con tutte le chiavi (ordine inserimento).    |
| `Collection<V> values()`              | Restituisce tutti i valori (ordine inserimento).                |
| `Set<Map.Entry<K,V>> entrySet()`      | Restituisce tutte le coppie chiave-valore (ordine inserimento). |

---
### ESEMPIO

```java
import java.util.LinkedHashMap;
import java.util.Map;

public class LinkedHashMapExample {
    public static void main(String[] args) {
        // Creazione LinkedHashMap
        LinkedHashMap<String, Integer> scudetti = new LinkedHashMap<>();

        // Inserimento elementi
        scudetti.put("Inter", 19);
        scudetti.put("Napoli", 4);
        scudetti.put("Pro Vercelli", 7);

        // Accesso (modifica l'ordine solo se si abilita l'ordine accesso)
        System.out.println("Scudetti Napoli: " + scudetti.get("Napoli"));

        // Iterazione: l'ordine rispecchia l'inserimento
        System.out.println("Tutte le squadre in ordine:");
        for (Map.Entry<String, Integer> entry : scudetti.entrySet()) {
            System.out.println(entry.getKey() + " → " + entry.getValue());
        }

        // Sovrascrittura valore
        scudetti.put("Inter", 20);

        // Rimozione
        scudetti.remove("Napoli");

        System.out.println("\nDopo aggiornamenti:");
        for (Map.Entry<String, Integer> entry : scudetti.entrySet()) {
            System.out.println(entry.getKey() + " → " + entry.getValue());
        }
    }
}
```

**Output possibile:**

```yaml
Scudetti Napoli: 4
Tutte le squadre in ordine:
Inter → 19
Napoli → 4
Pro Vercelli → 7

Dopo aggiornamenti:
Inter → 20
Pro Vercelli → 7
```

---