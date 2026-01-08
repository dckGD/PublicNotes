[[Classes#INTERFACCIA|Interfaccia]] contenuta nel [[Packages|package]] `java.lang`. 
**Funzione:** è usata per definire l’**ordinamento naturale** degli oggetti di una classe. Implementando `Comparable`, una classe stabilisce un **criterio di confronto “naturale”** tra i suoi oggetti, permettendo di ordinarli.
**Utilizzo tipico:** l'ordinamento avviene tramite `Collections.sort()` o strutture dati ordinate come `TreeSet` e `TreeMap`.

---
### METODO `compareTo()`

```java
public interface Comparable<T> {
    int compareTo(T o);
}
```

La classe che implementa `Comparable` deve definire il metodo:

```java
@Override
int compareTo(T other);
```

Il metodo `compareTo` confronta l’oggetto corrente (`this`) con l’oggetto `other` e deve restituire:

- **Un numero negativo** se `this` è "minore di" `other`
- **Zero** se `this` è "uguale a" `other
- **Un numero positivo** se `this` è "maggiore di" `other`

---
### ESEMPIO

```java
public class Persona implements Comparable<Persona> {
    private String nome;
    private int eta;

    public Persona(String nome, int eta) {
        this.nome = nome;
        this.eta = eta;
    }

    // Ordinamento naturale per età
    @Override
    public int compareTo(Persona other) {
        return this.eta - other.eta;  // crescente per età
    }

    @Override
    public String toString() {
        return nome + " (" + eta + " anni)";
    }
}
```

**Uso:**

```java
import java.util.ArrayList;
import java.util.Collections;

public class Main {
    public static void main(String[] args) {
        ArrayList<Persona> persone = new ArrayList<>();
        persone.add(new Persona("Giulio", 20));
        persone.add(new Persona("Andrea", 15));
        persone.add(new Persona("Simone", 25));

        Collections.sort(persone);

        for (Persona p : persone) {
            System.out.println(p);
        }
    }
}
```

**Output:**

```yaml
Andrea (15 anni)
Giulio (20 anni)
Simone (25 anni)
```

---