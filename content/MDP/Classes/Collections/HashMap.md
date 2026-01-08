La classe **`HashMap`** implementa l’interfaccia `Map<K, V>`. Una **`HashMap`** memorizza coppie chiave-valore, dove ogni chiave è **unica** e può essere associata a un singolo valore. Internamente utilizza una **tabella hash** per garantire accessi e modifiche **in tempo costante medio O(1)**. Può contenere **una sola chiave `null`** e valori `null` multipli.

>**Package**: [[JDK Packages#**`java.util`**|java.util]].
>**Interfaccia di riferimento**: [[Collection#`Map<K, V>`|Map]] (che estende [[Collection]]).

---
### CARATTERISTICHE PRINCIPALI

**Chiavi uniche**: l’inserimento di una chiave già esistente sovrascrive il valore associato.
**Una chiave null consentita**, più valori null permessi.
**Nessun ordine garantito** di chiavi e valori.
**Non sincronizzata** → non [[Multithreading|thread-safe]] (per versione sincronizzata, usare `Collections.synchronizedMap()` o `ConcurrentHashMap`).
Prestazioni ottimali quando il **load factor** (predefinito 0.75) è mantenuto bilanciato.
Operazioni di ricerca, inserimento e rimozione **O(1)** in media, **O(n)** nel caso peggiore (molte collisioni).

---
### METODI PRINCIPALI

|Metodo|Descrizione|
|---|---|
|`V put(K key, V value)`|Inserisce o aggiorna una coppia chiave-valore.|
|`V get(Object key)`|Restituisce il valore associato a una chiave.|
|`V remove(Object key)`|Rimuove la coppia chiave-valore associata a quella chiave.|
|`boolean containsKey(Object key)`|Verifica se la chiave è presente.|
|`boolean containsValue(Object value)`|Verifica se il valore è presente.|
|`int size()`|Restituisce il numero di elementi.|
|`void clear()`|Svuota la mappa.|
|`Set<K> keySet()`|Restituisce un set di tutte le chiavi.|
|`Collection<V> values()`|Restituisce tutti i valori.|
|`Set<Map.Entry<K,V>> entrySet()`|Restituisce tutte le coppie chiave-valore come oggetti `Map.Entry`.|

---
### ESEMPIO

```java
import java.util.HashMap;
import java.util.Map;

public class HashMapExample {
    public static void main(String[] args) {
        // Creazione di una HashMap con chiavi String e valori Integer
        HashMap<String, Integer> scudetti = new HashMap<>();

        // Aggiunta di elementi
        scudetti.put("Inter", 19);
        scudetti.put("Napoli", 4);
        scudetti.put("Pro Vercelli", 7);
        scudetti.put("Inter", 20); // Sovrascrive il valore precedente

        // Accesso a un valore
        System.out.println("Scudetti Inter: " + scudetti.get("Inter"));

        // Iterazione su entrySet
        System.out.println("Tutte le squadre:");
        for (Map.Entry<String, Integer> entry : scudetti.entrySet()) {
            System.out.println(entry.getKey() + ": " + entry.getValue());
        }

        // Verifica presenza
        System.out.println("C'è Napoli?"+scudetti.containsKey("Napoli"));
        System.out.println("Qualcuno ne ha 5?"+scudetti.containsValue(5));
    }
}
```

**Output possibile:**

```yaml
Scudetti Inter: 20
Tutte le squadre:
Inter: 20
Napoli: 4
Pro Vercelli: 7
C è Napoli? true (purtroppo)
Qualcuno ne ha 5? false
```

---