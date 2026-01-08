Un **riferimento a metodo** (_method reference_) in Java è una scorciatoia sintattica per dire:

> "Esegui **quel** metodo già esistente, invece di scriverlo come lambda."

In pratica è una forma abbreviata di una **[[Lambda Functions|lambda expression]]** che chiama direttamente un metodo già definito.  
La sintassi usa l’operatore `::`.

**Tipi di riferimenti a metodo**:

|Tipo di riferimento|Sintassi|Esempio|
|---|---|---|
|Metodo statico|`Classe::metodoStatico`|`Math::max`|
|Metodo di istanza di un oggetto specifico|`oggetto::metodoIstanza`|`str::toLowerCase`|
|Metodo di istanza di un oggetto di tipo specifico|`Classe::metodoIstanza`|`String::toUpperCase`|
|Costruttore|`Classe::new`|`ArrayList::new`|

Un riferimento a metodo **può essere usato solo quando il contesto richiede un'interfaccia funzionale**, cioè un’interfaccia con **un solo metodo astratto**.

**Esempio:**

```java
@FunctionalInterface
interface Operazione {
    int esegui(int a, int b);
}
```

**Posso implementarla con:**

```java
Operazione somma = (a, b) -> Integer.sum(a, b); // lambda
```

**Oppure con riferimento a metodo:**

```java
Operazione somma = Integer::sum;
```

Qui `Integer::sum` è compatibile con `Operazione` perché:
- `Operazione` ha un solo metodo astratto `esegui(int, int)`
- `Integer.sum(int, int)` ha **la stessa firma** (parametri e tipo di ritorno compatibili)

---