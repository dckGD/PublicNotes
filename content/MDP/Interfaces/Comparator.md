[[Classes#Interfaccia funzionale|Interfaccia funzionale]] contenuta nel [[Packages|package]] `java.util`. 
**Funzione:** Definisce un criterio di ordinamento esterno a una classe, permettendo di confrontare **due oggetti distinti** senza che questi implementino `Comparable`.
**Utilizzo tipico:** Ordinamento di collezioni o array, passando il comparatore a metodi come `Collections.sort()` o ai costruttori di strutture dati ordinate (es. `TreeSet`, `TreeMap`).

---
### CARATTERISTICHE PRINCIPALI

**Ordinamento esterno:** A differenza di `Comparable`, non richiede di modificare la classe degli oggetti da ordinare.
**Più criteri:** È possibile definire diversi comparatori per lo stesso tipo di oggetto, cambiando il criterio di ordinamento a seconda delle necessità.
**Interfaccia funzionale:** Ha un solo metodo astratto (`compare`) ed è quindi compatibile con espressioni lambda e reference a metodi.
**Utilizzo con collezioni:** Può essere passato ai costruttori di collezioni ordinate (ad esempio `TreeSet`) per determinare l’ordine degli elementi.

---
### METODI PRINCIPALI

| Metodo                                      | Descrizione                                  |
| ------------------------------------------- | -------------------------------------------- |
| `compare(T o1, T o2)`                       | Metodo base per confrontare due oggetti      |
| `equals(Object obj)`                        | Verifica di uguaglianza dei comparatori      |
| `comparing(...)`                            | Crea un comparatore da una chiave            |
| `comparing(...)` (con comparator di chiave) | Permette compare personalizzato della chiave |
| `reverseOrder()`                            | Ordine naturale inverso                      |
| `nullsFirst(...)`                           | `null` ordinati per primi                    |
| `nullsLast(...)`                            | `null` ordinati per ultimi                   |
| `reversed()`                                | Inverte l'ordine di un comparatore esistente |
| `thenComparing(...)`                        | Aggiunge criteri di ordinamento secondari    |

---
### ESEMPIO

**Classe Persona:**

```java
import java.util.*;

class Persona {
    String nome;
    int eta;

    Persona(String nome, int eta) {
        this.nome = nome;
        this.eta = eta;
    }

    public String getNome() {
        return nome;
    }

    public int getEta() {
        return eta;
    }

    @Override
    public String toString() {
        return nome + " (" + eta + ")";
    }
}
```

**Main:**

```java
public class Main {
    public static void main(String[] args) {
        List<Persona> persone = Arrays.asList(
            new Persona("Giulio", 20),
            new Persona("Simone", 15),
            new Persona("Andrea", 25),
            new Persona("Simone", 30)
        );

        // Ordinamento per età crescente
        persone.sort(Comparator.comparing(Persona::getEta));
        System.out.println("Età crescente: " + persone);

        // Ordinamento per età decrescente (reverseOrder)
        persone.sort(Comparator.comparing(Persona::getEta).reversed());
        System.out.println("Età decrescente: " + persone);

        // Ordinamento per nome alfabetico
        persone.sort(Comparator.comparing(Persona::getNome));
        System.out.println("Nome crescente: " + persone);

        // Ordinamento per nome alfabetico ignorando maiuscole/minuscole
        persone.sort(Comparator.comparing(
	        Persona::getNome, String.CASE_INSENSITIVE_ORDER));
        System.out.println("Nome (case-insensitive): " + persone);

        // Ordinamento per nome, poi per età se i nomi sono uguali
        persone.sort(
            Comparator.comparing(Persona::getNome)
                      .thenComparing(Persona::getEta)
        );
        System.out.println("Nome, poi età: " + persone);
    }
}
```

**Output:**

```yaml
Età crescente: [Simone (15), Giulio (20), Andrea (25), Simone (30)]
Età decrescente: [Simone (30), Andrea (25), Giulio (20), Simone (15)]
Nome crescente: [Andrea (25), Giulio (20), Simone (15), Simone (30)]
Nome (case-insensitive): [Andrea (25), Giulio (20), Simone (15), Simone (30)]
Nome, poi età: [Andrea (25), Giulio (20), Simone (15), Simone (30)]
```

---