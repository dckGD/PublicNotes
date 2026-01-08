**L'autoboxing** è il processo in cui un **tipo primitivo** viene automaticamente convertito in un **oggetto della classe wrapper** corrispondente. Questo accade implicitamente quando si assegnano valori di tipi primitivi a variabili di tipo wrapper, o quando i tipi primitivi vengono utilizzati in contesti che richiedono oggetti. Ad esempio: un tipo primitivo come `boolean` viene automaticamente "boxed" in un oggetto `Boolean`.

**Esempio di autoboxing:**

```java
public class Main {
    public static void main(String[] args) {
        int x = 10;  // Tipo primitivo
        Integer y = x;  // Autoboxing
        System.out.println(y);  // Output: 10
    }
}
```

In questo esempio, la variabile `x` di tipo `int` viene automaticamente convertita in un oggetto di tipo `Integer` quando assegnata a `y`.

---