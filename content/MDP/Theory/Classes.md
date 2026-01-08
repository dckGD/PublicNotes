La **classe** è una struttura che definisce **proprietà** (campi) e **comportamenti** (metodi) di un oggetto. È come un **modello** o un **progetto** da cui vengono creati gli oggetti.

**Contiene:**

- **campi**: sono i dati che descrivono l'oggetto.
- **metodi**: I metodi sono i comportamenti associati a una classe. Possono manipolare i dati di un oggetto e restituire risultati. I metodi possono essere **pubblici** o **privati**, a seconda della visibilità desiderata.
- **costruttori**: Il costruttore è un metodo speciale di una classe che viene chiamato quando un oggetto viene creato. Viene utilizzato per inizializzare i dati dell'oggetto. I costruttori hanno lo stesso nome della classe e non restituiscono alcun valore.

```java
public class NomeClasse { // corpo della classe
    definizione-di-costruttori
    definizione-di-campi (statici e non)
    definizione-di-metodi (statici e non)
}
```

**Un esempio di classe:**

```java
// Definizione della classe Persona
class Persona {
    // Campi (variabili) della classe
    String nome;
    int eta;
    
    // Costruttore della classe Persona
    // Viene chiamato quando creiamo un nuovo oggetto della classe
    Persona(String nome, int eta) {
        this.nome = nome;  
        // Inizializza il campo nome con il valore passato al costruttore
        this.eta = eta;    
        // Inizializza il campo eta con il valore passato al costruttore
    }
    
    // Metodo della classe che stampa un saluto
    void saluta() {
        System.out.println("Ciao sono " + nome);
    }
}
```

---
### SUPERCLASSE E SOTTOCLASSE

In Java, una **classe può [[OOP#Ereditarietà (Inheritance)|ereditare]] da un’altra classe** tramite la parola chiave `extends`.

La **classe da cui si eredita** è chiamata **superclasse** o **classe padre**.
La **classe che eredita** è la **sottoclasse** o **classe figlia**.

**Esempio:**

```java
public class Giocatore {
	protected String nome;
	protected String cognome;
	Giocatore(String nome, String cognome) {
		this.nome = nome;
		this.cognome = cognome;
	}
    public void corri() {
        System.out.println("sto correndo");
    }
}

public class Portiere extends Giocatore {
	Portiere(String nome, String cognome) {
		super(nome, cognome);
	}
    public void para() {
        System.out.println("goal");
    }
}
```

**Uso:**

```java
Portiere p = new Portiere("Carlo", "Pinsoglio");
p.corri();  // metodo ereditato
p.para(); // metodo proprio
```

> Una sottoclasse eredita **tutti i metodi e gli attributi `public` e `protected`** della superclasse ([[Access Modifiers]]).

---
### CLASSE ASTRATTA

Una **classe astratta** è una classe **incompleta**, pensata per essere **estesa** da altre classi. Può contenere: metodi **con corpo** e metodi **astratti** (senza corpo), da **implementare obbligatoriamente** nelle sottoclassi.

**Esempio:**

```java
public abstract class Forma {
    public abstract double area();  // da implementare
    public void stampa() {
        System.out.println("Questa è una forma");
    }
}
```

**Classe concreta che la estende:**

```java
public class Cerchio extends Forma {
    private double raggio;

    public Cerchio(double raggio) {
        this.raggio = raggio;
    }

	@Override
    public double area() {
        return Math.PI * raggio * raggio;
    }
}
```

> Non si può scrivere `new Forma()`, ma solo `new Cerchio()`.

**Usa una classe astratta quando:**

- Vuoi **fornire una base comune** per più classi, ma **non ha senso istanziarla da sola**
- Alcuni metodi devono essere **comuni**, altri **obbligatoriamente implementati**

---
### INTERFACCIA

Un’**interfaccia** è un contratto: specifica **cosa una classe deve fare**, **non come**.  
Tutti i metodi in un'interfaccia sono per default **pubblici e astratti** ([[Access Modifiers]]).

**Esempio:**

```java
public interface Predatore {
    void caccia();
}

public interface Preda {
    void scappa();
}
```

**Classi che implementano:**

```java
public class Leone implements Predatore {
	@Override
    public void caccia() {
        System.out.println("Il leone caccia");
    }
}

public class Gazzella implements Preda {
	@Override
    public void scappa() {
        System.out.println("La gazzella sta scappando");
    }
}
```

Una classe può **implementare più interfacce**, ma può estendere solo **una classe**:

```java
public class Pesce extends Animale implements Preda, Predatore {
    ...
}
```

**Usa un’interfaccia quando:**

- Vuoi definire un **contratto** che più classi (non necessariamente imparentate) devono rispettare
- Hai bisogno di **ereditarietà multipla** (Java permette più interfacce, ma una sola superclasse)

---
#### Interfaccia funzionale

Un’interfaccia funzionale è una **interfaccia che ha un solo metodo (astratto)**. Le interfacce funzionali sono utili perché a queste fanno riferimento le [[Lambda Functions|funzioni lambda]].

**Esempio:**

```java
@FunctionalInterface
interface Operazione {
    int esegui(int a, int b);
}
```

Qui, `Operazione` è un’interfaccia funzionale perché ha **un solo metodo astratto**: `esegui`.

>L'annotazione `@FunctionalInterface`è **facoltativa**, ma **consigliata**: serve per dire esplicitamente che quell’interfaccia è destinata ad avere **un solo metodo astratto**.

**Interfacce funzionali già presenti in Java:**

Dal pacchetto `java.util.function`, Java 8 fornisce tante interfacce funzionali già pronte: ^217d6d

```java
import java.util.function.*;
```

| Interfaccia         | Metodo                | Significato                              |
| ------------------- | --------------------- | ---------------------------------------- |
| `Runnable`          | `void run()`          | Nessun argomento, nessun ritorno         |
| `Consumer<T>`       | `void accept(T t)`    | Prende un valore, non restituisce        |
| `Supplier<T>`       | `T get()`             | Non prende nulla, restituisce un valore  |
| `Function<T,R>`     | `R apply(T t)`        | Da T a R                                 |
| `Predicate<T>`      | `boolean test(T t)`   | Restituisce vero/falso su T              |
| `BinaryOperator<T>` | `T apply(T t1, T t2)` | Operazione su due T che restituisce un T |

---
### CLASSE INTERNA

Una **classe interna** è una classe **dichiarata all’interno di un’altra classe**.

**Classe interna non statica**: Ha accesso ai membri dell’oggetto esterno.

```java
public class Esterna {
    private String messaggio = "Ciao";

    class Interna {
        public void stampa() {
            System.out.println(messaggio);
        }
    }
}
```

**Classe interna statica**: È indipendente dall’istanza esterna.

```java
public class Esterna {
    static class Statica {
        public void stampa() {
            System.out.println("Classe statica interna");
        }
    }
}
```

**Classe locale (in un metodo)**: Definita all’interno di un metodo.

```java
public void metodo() {
    class Locale {
        void stampa() {
            System.out.println("Sono locale");
        }
    }
    new Locale().stampa();
}
```

**Usa una classe interna quando:**

- Hai una classe che **ha senso solo all’interno di un’altra**
- Vuoi **nascondere** un’implementazione al mondo esterno

---
### CLASSE ANONIMA

Una **classe anonima** è una classe **senza nome**, creata direttamente all’interno del codice per implementare velocemente un'interfaccia o estendere una classe.

**Esempio:**

```java
Runnable r = new Runnable() {
    public void run() {
        System.out.println("Thread anonimo");
    }
};
new Thread(r).start();
```

**Oppure con override rapido:**

```java
Button b = new Button();
b.setOnClickListener(new OnClickListener() {
    public void onClick() {
        System.out.println("Click!");
    }
});
```

> Utile per **eventi, callback, codice rapido**.

**Usa una classe anonima quando:**

- Vuoi **sovrascrivere velocemente** un metodo di una classe o interfaccia
- Hai bisogno di un’**istanza una tantum** (non vuoi riusare quella classe)
- Vuoi implementare **callback, eventi o interfacce funzionali** 

---
### CLASSE STATICA

Una **classe statica** è una [[Classes#CLASSE INTERNA|classe interna]] dichiarata con `static`.  
È spesso usata per **raggruppare metodi di utilità** o **costanti**, perché **non ha bisogno di un'istanza esterna**.

**Esempio:**

```java
public class MathUtils {
    public static class Operazioni {
        public static int somma(int a, int b) {
            return a + b;
        }
    }
}
```

**Uso:**

```java
int x = MathUtils.Operazioni.somma(3, 4);
```

> Tutto è accessibile **senza creare oggetti**.

---