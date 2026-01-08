La **Programmazione Orientata agli Oggetti** (OOP) è un paradigma di programmazione che organizza il software utilizzando concetti centrati su **oggetti** e **classi**. Ogni oggetto è una rappresentazione di entità del mondo reale e può avere **proprietà** (attributi) e **comportamenti** (metodi). In Java, la programmazione orientata agli oggetti è alla base della struttura del linguaggio e permette di scrivere codice modulare, riutilizzabile e facilmente modificabile.

---
### OOP IN JAVA

La Programmazione Orientata agli Oggetti (OOP) è un approccio che organizza un programma in **oggetti**, ognuno dei quali è un'istanza di una **classe**. Gli oggetti interagiscono tra di loro attraverso metodi, utilizzando i dati definiti nelle loro classi. Questo paradigma è focalizzato su incapsulamento, ereditarietà, polimorfismo e astrazione, che sono concetti fondamentali in Java.

---
### ELEMENTI FONDAMENTALI DELL'OOP IN JAVA

#### Classi

La **classe** è una struttura che definisce **proprietà** (campi) e **comportamenti** (metodi) di un oggetto. È come un **modello** o un **progetto** da cui vengono creati gli oggetti.

→ Leggi [[Classes|qui]].

---
#### Oggetti

Un oggetto è un'istanza di una **classe**. Quando una classe è definita, non esiste ancora un oggetto. L'oggetto viene creato usando la **parola chiave `new`**. ^33849f

Un esempio della creazione di un oggetto:

```java
public class Main {
    public static void main(String[] args) {
        // Creazione di un oggetto della classe Persona
        Persona p1 = new Persona(); // Creo p1
        p1.nome = "Giulio"; // Assegnazione
        p1.eta = 20; // Assegnazione
        p1.saluta(); // Chiamata del metodo saluta() per p1
    }
}
```

---
### PRINCIPALI CARATTERISTICHE DELL'OOP

#### Incapsulamento (Encapsulation)

L'incapsulamento è il principio che consiste nel **nascondere i dettagli interni** dell'oggetto e nel **fornire accesso ai dati** solo tramite metodi pubblici (getter e setter). Questo impedisce la modifica diretta delle variabili da parte di codice esterno, proteggendo i dati dell'oggetto.

- **Getter**: Metodo pubblico che permette di leggere il valore di una proprietà.
- **Setter**: Metodo pubblico che permette di modificare il valore di una proprietà.

**Esempio:**

```java
class Persona {
    
    // Proprietà private (non accessibili direttamente dall'esterno)
    private String nome;
    private int eta;
    
    // Getter per nome
    public String getNome() {
        return nome;
    }
    
    // Setter per nome
    public void setNome(String nome) {
        this.nome = nome;
    }
}

public class Main {
    public static void main(String[] args) {
        // Creazione di un oggetto Persona
        Persona p1 = new Persona();
        
        // Utilizzo del setter per impostare i valori
        p1.setNome("Giulio");
        
        // Utilizzo del getter per ottenere i valori
        System.out.println("Nome: " + p1.getNome());  
        // Stampa: Nome: Giulio
    }
}
```

---
#### Ereditarietà (Inheritance)

L'ereditarietà è il meccanismo che permette a una **classe figlia** di ereditare proprietà e metodi da una **classe genitore**. La classe figlia può estendere o **modificare** i comportamenti della classe genitore.

**Esempio:**

```java
// Superclasse
class Animale {
    String nome;

    Animale(String nome) {
        this.nome = nome;
    }

    void dorme() {
        System.out.println(nome + " sta dormendo...");
    }

    void verso() {
        System.out.println("Verso generico");
    }
}

// Sottoclasse
class Gatto extends Animale {

	String razza;
	
    Gatto(String nome, String razza) {
        super(nome); // richiamo al costruttore della superclasse
        this.razza = razza // attributo proprio
    }

    @Override
    void verso() { // metodo sovrascritto
        System.out.println(nome + " dice: Miao!");
    }

    void faLeFusa() { // metodo nuovo
        System.out.println(nome + " fa le fusa.");
    }
}

public class Main {
    public static void main(String[] args) {
        Gatto g = new Gatto("Stitch", "Ford Mustang GT350");
		
		g.nome;         // attributo ereditato
		g.razza;        // attributo proprio
        g.dorme();      // metodo ereditato
        g.verso();      // metodo sovrascritto
        g.faLeFusa();   // metodo della sottoclasse
    }
}
```

>`super(...)` nel costruttore di una sottoclasse serve a **richiamare esplicitamente il costruttore della superclasse**.

---
#### Polimorfismo (Polymorphism)

Il **polimorfismo** è la capacità di un oggetto di assumere molteplici forme. In pratica, permette di **trattare oggetti di diverse classi in modo uniforme** attraverso un'interfaccia comune (solitamente una superclasse o un'interfaccia), ma con comportamenti specifici per ciascuna classe.

- **Polimorfismo di inclusione** (o **runtime polymorphism**) tramite **metodi sovrascritti**   (`@Override`).
- **Polimorfismo di metodo** (o **compile-time polymorphism**) tramite **overloading** dei metodi.

**Esempio:**

```java
class Animale { 
    void fareVerso() {
        System.out.println("Verso generico");
    }
}

class Cane extends Animale {
    @Override
    void fareVerso() {
        System.out.println("Bau!");
    }
}

class Gatto extends Animale {
    @Override
    void fareVerso() {
        System.out.println("Miao!");
    }
}

public class Main {
    public static void main(String[] args) {
        Animale animale1 = new Cane();  
        // Tratto Cane come un oggetto della superclasse Animale
        Animale animale2 = new Gatto();
        // Tratto Gatto come un oggetto della superclasse Animale
        animale1.fareVerso();  // "Bau!"
        animale2.fareVerso();  // "Miao!"
    }
}
```

---
#### Astrazione (Abstraction)

L'astrazione è il processo di **nascondere i dettagli complessi** e di mostrare solo ciò che è essenziale. In Java, l'astrazione può essere ottenuta tramite **[[Classes#CLASSE ASTRATTA|classi astratte]] e [[Classes#INTERFACCIA|interfacce]]**.

**Esempio:**

```java
// Classe astratta con metodi astratti e non
public abstract class Animale {

    protected String nome;
    public Animale(String nome) { 
	    this.nome = nome; 
    }
    public abstract void verso();
    public void dorme() { 
	    System.out.println(nome + " sta dormendo"); 
	}
}

// Interfacce di comportamento
public interface Predatore { 
	void caccia(); 
}

public interface Preda { 
	void scappa(); 
}

// Classe concreta
public class Leone extends Animale implements Predatore {
    public Leone(String nome) { 
	    super(nome); 
	}
    @Override 
    public void verso() { 
	    System.out.println("Roar"); 
	}
    @Override 
    public void caccia() { 
	    System.out.println("Il leone caccia"); 
	}
}

// Altra classe concreta
public class Gazzella extends Animale implements Preda {
    public Gazzella(String nome) { 
	    super(nome); 
	}
    @Override 
    public void verso() { 
	    System.out.println("Swosh"); 
	}
    @Override 
    public void scappa() { 
	    System.out.println("La gazzella scappa"); 
	}
}
```

---




