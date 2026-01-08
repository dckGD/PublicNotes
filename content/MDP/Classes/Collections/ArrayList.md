La classe `ArrayList` è una **classe** che implementa l’interfaccia `List` e rappresenta una **lista dinamica** basata su array. A differenza di un array tradizionale (`int[]`), la sua dimensione può crescere o ridursi automaticamente. Può contenere elementi duplicati e mantiene **l’ordine di inserimento**.

>**Package**: [[JDK Packages#**`java.util`**|java.util]].
>**Interfaccia di riferimento**: [[Collection#`List<E>`|List]] (che estende [[Collection]]).

---
### CARATTERISTICHE PRINCIPALI

**Struttura interna**: array ridimensionabile automaticamente.
**Ordine garantito**: mantiene l’ordine in cui gli elementi sono stati inseriti.
**Accesso veloce per indice**: tempo di accesso O(1) per lettura/scrittura.
**Inserimenti e rimozioni**: veloci in fondo alla lista. Più lenti all’inizio o in mezzo (perché richiedono lo spostamento degli elementi).
**Non sincronizzata**: più veloce, ma non [[Multithreading|thread-safe]].
**Elementi null**: ammessi.

---
### METODI PRINCIPALI

| Metodo                     | Descrizione                                        |
| -------------------------- | -------------------------------------------------- |
| `add(E e)`                 | Aggiunge un elemento in fondo.                     |
| `add(int index, E e)`      | Inserisce un elemento in una posizione specifica.  |
| `get(int index)`           | Restituisce l’elemento all’indice indicato.        |
| `set(int index, E e)`      | Sostituisce l’elemento all’indice indicato.        |
| `remove(int index)`        | Rimuove l’elemento all’indice indicato.            |
| `remove(Object o)`         | Rimuove la prima occorrenza dell’oggetto indicato. |
| `size()`                   | Restituisce il numero di elementi.                 |
| `isEmpty()`                | Verifica se la lista è vuota.                      |
| `contains(Object o)`       | Verifica se la lista contiene un elemento.         |
| `clear()`                  | Rimuove tutti gli elementi.                        |
| `iterator()`               | Restituisce un `Iterator` per iterare sulla lista. |
| `forEach(Consumer action)` | Esegue un’azione per ogni elemento.                |

---
### ESEMPIO

```java
import java.util.ArrayList;

public class EsempioArrayList {
    public static void main(String[] args) {
        // Creazione di un ArrayList di Stringhe
        ArrayList<String> listaSlime = new ArrayList<>();

        // Aggiunta di elementi
        listaSlime.add("Papa V");
        listaSlime.add("Nerissima Serpe");
        listaSlime.add("Fritu");

        // Inserimento in posizione specifica
        listaSlime.add(1, "Mario");

        // Stampa della lista
        System.out.println("Lista Slime: " + listaSlime);

        // Accesso a un elemento
        System.out.println("Primo elemento: " + listaSlime.get(0));

        // Modifica di un elemento
        listaSlime.set(2, "Luigi");

        // Rimozione di un elemento
        listaSlime.remove("Fritu");

        // Verifica presenza
        System.out.println("C'é Papa?" + listaSlime.contains("Papa V"));

        // Iterazione con for-each
        System.out.println("\nLista finale:");
        for (String prodotto : listaSlime) {
            System.out.println("- " + slime);
        }
    }
}
```

**Output possibile**:

```yaml
Lista slime: [Papa V, Mario, Nerissima Serpe, Fritu]
Primo elemento: Papa V
C é Papa? true

Lista finale:
- Papa V
- Mario
- Luigi
```

---