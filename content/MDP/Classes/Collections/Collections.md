La classe `Collections` è una **classe di utilità** contenente **metodi statici** per operare su collezioni (`List`, `Set`, `Map`, ecc.) e per creare collezioni particolari (immutabili, sincronizzate, singleton, ecc.).

La classe **`Collections` non può essere istanziata e non estende alcuna interfaccia** del [[Collection#FRAMEWORK COLLECTION (GERARCHIA)|Java Collections Framework]], e nemmeno **implementa** interfacce come `Collection` o `List`. `Collections` è **solo** una **classe di utilità finale** (`public final class Collections`) che contiene **metodi statici**.

>**Package**: [[JDK Packages#**`java.util`**|java.util]].

---
### CARATTERISTICHE PRINCIPALI

**Classe finale**: non estendibile.
**Metodi statici**: non serve creare un’istanza per usarla.
**Funzioni di utilità**: ordinamento, ricerca, riempimento, copia, inversione, conteggio, ecc.
**Creazione di collezioni particolari**.
**Supporta generics**: per maggiore sicurezza sui tipi.
**Operazioni ottimizzate**: molte funzioni sfruttano algoritmi interni ad alte prestazioni.

---
### METODI PRINCIPALI

|Metodo|Descrizione|
|---|---|
|`sort(List<T> list)`|Ordina la lista in ordine naturale.|
|`sort(List<T> list, Comparator<? super T> c)`|Ordina la lista usando un `Comparator` personalizzato.|
|`reverse(List<?> list)`|Inverte l’ordine degli elementi nella lista.|
|`shuffle(List<?> list)`|Mischia casualmente gli elementi della lista.|
|`swap(List<?> list, int i, int j)`|Scambia gli elementi agli indici indicati.|
|`fill(List<? super T> list, T obj)`|Sostituisce tutti gli elementi con l’oggetto indicato.|
|`copy(List<? super T> dest, List<? extends T> src)`|Copia gli elementi da una lista sorgente a una destinazione (dimensione uguale o maggiore).|
|`binarySearch(List<? extends T> list, T key)`|Ricerca binaria (lista ordinata).|
|`max(Collection<? extends T> coll)`|Restituisce l’elemento massimo (ordine naturale).|
|`min(Collection<? extends T> coll)`|Restituisce l’elemento minimo (ordine naturale).|
|`frequency(Collection<?> c, Object o)`|Conta quante volte un elemento appare nella collezione.|
|`unmodifiableList(...)`|Rende la lista non modificabile (immutabile).|
|`synchronizedList(List<T> list)`|Rende la lista thread-safe (sincronizzata).|
|`singleton(T o)`|Crea un set contenente un solo elemento.|

---
### ESEMPIO

```java
import java.util.*;

public class EsempioCollections {
    public static void main(String[] args) {
        List<String> nomi = new ArrayList<>();
        nomi.add("Giulio");
        nomi.add("Andrea");
        nomi.add("Simone");

        // Ordinamento
        Collections.sort(nomi);
        System.out.println("Ordinati: " + nomi);

        // Inversione
        Collections.reverse(nomi);
        System.out.println("Invertiti: " + nomi);

        // Mischiare
        Collections.shuffle(nomi);
        System.out.println("Mischiati: " + nomi);

        // Elemento massimo e minimo
        System.out.println("Max: " + Collections.max(nomi));
        System.out.println("Min: " + Collections.min(nomi));

        // Frequenza di un elemento
        System.out.println("Frequenza di 'Andrea': " + Collections.frequency(nomi, "Andrea"));

        // Lista non modificabile
        List<String> immutabile = Collections.unmodifiableList(nomi);
        // immutabile.add("Nuovo"); // Genera UnsupportedOperationException
    }
}
```

**Output possibile:**

```yaml
Ordinati: [Andrea, Giulio, Simone]
Invertiti: [Simone, Giulio, Andrea]
Mischiati: [Giulio, Andrea, Simone]
Max: Simone
Min: Andrea
Frequenza di 'Andrea': 1
```

---