Le variabili in Java hanno tutte un tipo e vengono classificate in base a:
### AMBITO (SCOPE)

Questa classificazione dipende da dove e per quanto tempo la variabile è accessibile.
#### Variabili locali

- Dichiarate all'interno di un metodo, costruttore o blocco.
- Devono essere inizializzate prima dell'uso.
- Non hanno valori predefiniti.
- Esistono solo durante l'esecuzione del metodo o del blocco.

```java
class Numero {
	public void metodo() {
	    int numero = 11; // Variabile locale
	    System.out.println(numero);
	}
}
```

#### Variabili d'istanza (non `static`)

- Dichiarate all'interno di una classe, ma fuori dai metodi.
- Ogni istanza (oggetto) della classe ha **la propria copia** del campo.
- Si accede a un campo di istanza solo tramite un oggetto (`oggetto.campo`).
- Ogni oggetto può avere un valore diverso per lo stesso campo.

```java
class Persona {
    String nome; // Variabile d'istanza (default null)
    int eta;     // Variabile d'istanza (default 0)
}
```

#### Variabili di classe (`static`)

- Appartengono alla **classe** e non a una singola istanza.
- Esiste **una sola copia** del campo statico, condivisa da tutte le istanze della classe.
- Si accede a un campo statico tramite il nome della classe (`Classe.campoStatico`) o direttamente all'interno della classe.
- Tutti gli oggetti hanno lo stesso valore per quel campo.

```java
class Contatore {
    static int conteggio = 0; // Variabile di classe
}
```

---
### TIPO DI DATO

Questa classificazione dipende dal [[Types|tipo]] di valore che la variabile può contenere (variabili primitive e di riferimento).

---
### MODIFICATORE D'ACCESSO

Questa classificazione dipende dalla [[Access Modifiers|visibilità]] della variabile.

```java
class Prova {
    private int privata;      // Solo nella classe
    int defaultVar;           // Solo nello stesso package
    protected int protetta;   // Package + sottoclassi
    public int pubblica;      // Ovunque
}
```

---
### MODIFICATORE SPECIALE

Questa classificazione dipende da [[Special Modifiers|modificatori speciali]].

---