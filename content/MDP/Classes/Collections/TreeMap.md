La classe **`TreeMap`** implementa l’interfaccia `NavigableMap<K, V>` (che estende `SortedMap<K, V>` e quindi `Map<K, V>`).  
Una **`TreeMap`** memorizza coppie chiave-valore in ordine **naturale** delle chiavi o secondo un **comparatore personalizzato** fornito al momento della creazione.  
Internamente è basata su un **albero rosso-nero bilanciato**, che garantisce operazioni di ricerca, inserimento e cancellazione in **tempo logaritmico O(log n)**.

>**Package**: [[JDK Packages#**`java.util`**|java.util]].
>**Interfaccia di riferimento**: [[Collection#`Map<K, V>`|Map]] (che estende [[Collection]]).

---
### CARATTERISTICHE PRINCIPALI

**Ordinamento delle chiavi garantito**: l’iterazione segue l’ordine naturale o il comparatore fornito.  
**Chiavi uniche**: come tutte le mappe, una chiave può apparire una sola volta (valore aggiornato se chiave già presente).  
**Non permette chiavi null** (perché l’ordinamento su `null` non è definito), ma permette valori `null`.  
**Non sincronizzato**: non [[Multithreading|thread-safe]]; per usi concorrenti servono wrapper o `ConcurrentSkipListMap`.  
**Efficienza**: operazioni in O(log n) grazie all’albero bilanciato.  
**Supporta operazioni avanzate** come sotto-mappe (`subMap`), chiavi min/max, navigazione ordinata.

---
### METODI PRINCIPALI

|Metodo|Descrizione|
|---|---|
|`V put(K key, V value)`|Inserisce o aggiorna la coppia chiave-valore.|
|`V get(Object key)`|Restituisce il valore associato a una chiave.|
|`V remove(Object key)`|Rimuove la coppia associata alla chiave.|
|`boolean containsKey(Object key)`|Verifica se la chiave esiste nella mappa.|
|`boolean containsValue(Object value)`|Verifica se la mappa contiene il valore.|
|`int size()`|Numero di coppie presenti.|
|`void clear()`|Rimuove tutte le coppie chiave-valore.|
|`Set<K> keySet()`|Restituisce un set ordinato delle chiavi.|
|`Collection<V> values()`|Restituisce i valori (nell’ordine delle chiavi).|
|`Set<Map.Entry<K,V>> entrySet()`|Restituisce coppie chiave-valore ordinate.|
|`K firstKey()`|Restituisce la prima chiave (minima).|
|`K lastKey()`|Restituisce l’ultima chiave (massima).|
|`SortedMap<K,V> subMap(K fromKey, K toKey)`|Restituisce una vista della mappa in un intervallo di chiavi.|

---
### ESEMPIO

```java
import java.util.TreeMap;
import java.util.Map;

public class TreeMapExample {
    public static void main(String[] args) {
        // Creazione di una TreeMap con chiavi String e valori Integer
        TreeMap<String, Integer> scudetti = new TreeMap<>();

        // Inserimento elementi
        scudetti.put("Inter", 20);
        scudetti.put("Napoli", 4);
        scudetti.put("Pro Vercelli", 7);
        scudetti.put("Milan", 19);

        // Accesso a un valore
        System.out.println("Scudetti Napoli: " + scudetti.get("Napoli"));

        // Iterazione (ordina le chiavi in ordine alfabetico)
        System.out.println("Tutte le squadre in ordine alfabetico:");
        for (Map.Entry<String, Integer> entry : scudetti.entrySet()) {
            System.out.println(entry.getKey() + ": " + entry.getValue());
        }

        // Prima e ultima chiave
        System.out.println("Prima squadra: " + scudetti.firstKey());
        System.out.println("Ultima squadra: " + scudetti.lastKey());

        // Sotto-mappa (dalla A alla N esclusa)
        System.out.println("Squadre da A a N:");
        Map<String, Integer> sub = scudetti.subMap("A", "N");
        for (Map.Entry<String, Integer> entry : sub.entrySet()) {
            System.out.println(entry.getKey() + ": " + entry.getValue());
        }
    }
}
```

**Output possibile:**

```yaml
Scudetti Napoli: 4
Tutte le squadre in ordine alfabetico:
Inter: 20
Milan: 19
Napoli: 4
Pro Vercelli: 7
Prima squadra: Inter
Ultima squadra: Pro Vercelli
Squadre da A a N esclusa:
Inter: 20
Milan: 19
```

---