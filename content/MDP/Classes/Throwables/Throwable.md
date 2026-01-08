In Java, **`Throwable`** è la **superclasse di tutti gli oggetti che possono essere lanciati come eccezioni o errori**. Tutti gli oggetti che rappresentano un problema durante l'esecuzione di un programma devono derivare da `Throwable`.
Qualsiasi oggetto che si voglia **lanciare con `throw`** o **intercettare con `catch`** deve essere un'istanza di una sottoclasse di `Throwable`.

>**Package**: [[JDK Packages#**`java.lang`**|java.lang]]

---
### GERARCHIA DI `Throwable`

```scss
java.lang.Object
    └── java.lang.Throwable
          ├── java.lang.Error
          └── java.lang.Exception
```

Questa superclasse ha due sottoclassi principali:
**[[Error|Error]]**: problemi gravi e generalmente non recuperabili 
**[[Exception|Exception]]**: condizioni anomale che il programma può gestire

---
### COSTRUTTORI E METODI PRINCIPALI DI `Throwable`

Le classi che estendono `Throwable` [[OOP#Ereditarietà (Inheritance)|ereditano]] questi metodi utili per analizzare e stampare l’errore/eccezione:

|Metodo|Descrizione|
|---|---|
|`getMessage()`|Restituisce il messaggio dell'eccezione|
|`getCause()`|Restituisce la causa radice dell'eccezione|
|`printStackTrace()`|Stampa il trace dello stack dove è avvenuto l'errore|
|`toString()`|Restituisce una stringa con tipo e messaggio|

**Esempio:**

```java
try {
    throw new IllegalArgumentException("Parametro non valido");
} catch (Throwable t) {
    System.out.println("Errore: " + t.getMessage());
    t.printStackTrace();
}
```

---
