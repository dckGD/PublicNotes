**L'unboxing** è l'operazione inversa rispetto all'[[Autoboxing]]. Consiste nel **convertire un oggetto wrapper** (come `Integer`, `Double`, `Boolean`, ecc.) in un **tipo primitivo** corrispondente. Questa operazione avviene automaticamente quando un oggetto wrapper viene utilizzato in un contesto che richiede un tipo primitivo.

**Esempio di Unboxing:**

```java
public class Main {
    public static void main(String[] args) {
        Integer x = 10;  // Oggetto di tipo Integer
        int y = x;  // Unboxing:
        System.out.println(y);  // Output: 10
    }
}
```

In questo caso, l'oggetto `Integer x` viene automaticamente "unboxed" per ottenere il valore primitivo `int`.

---