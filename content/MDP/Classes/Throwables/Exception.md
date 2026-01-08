In Java, la classe **`Exception`** è una sottoclasse di [[Throwable]] che rappresenta **le condizioni anomale** o errori **che un programma può intercettare e gestire** durante l’esecuzione. Le [[Instance|istanze]] di `Exception` sono comunemente dette **eccezioni** e servono per segnalare problemi che non bloccano necessariamente il programma ma richiedono attenzione.

>**Package**: [[JDK Packages#**`java.lang`**|java.lang]]

---
### CLASSIFICAZIONE

Le eccezioni in Java si dividono principalmente in:

```scss
Throwable
 └── Exception
      ├── IOException               (checked)
      ├── ParseException            (checked)
      ├── ClassNotFoundException    (checked)
      └── RuntimeException          (unchecked)
		   ├── NullPointerException        (unchecked)
           ├── IllegalArgumentException    (unchecked)
           ├── ArithmeticException         (unchecked)
           ├── NumberFormatException       (unchecked)
           └── IndexOutOfBoundsException   (unchecked)
```

**Checked exceptions (eccezioni verificate)**
Devono essere dichiarate nel metodo con `throws` oppure gestite con `try-catch`.
Il compilatore verifica che siano correttamente gestite (da qui il termine "checked").
Se non gestite o dichiarate, il codice non compila.

**Unchecked exceptions (eccezioni non verificate)**
Sono sottoclassi di `RuntimeException`.
Rappresentano errori di programmazione, come errori logici o di sintassi che causano problemi a runtime.
Non è obbligatorio gestirle o dichiararle.

---
### POLITICA "CATCH OR DECLARE"

Secondo questa regola, un metodo che può generare una checked exception deve obbligatoriamente: **Gestirla localmente (CATCH)** oppure **Dichiararla (DECLARE)** nella propria intestazione. In mancanza di una di queste due azioni, il codice **non compila**:

---
#### Catch

L’eccezione viene **intercettata e gestita** nel corpo del metodo, tipicamente con un blocco `try-catch-finally`.

È il meccanismo di base per la gestione delle eccezioni.

**Esempio:**

```java
try {
    int risultato = 10 / 0;
} catch (ArithmeticException e) {
    System.out.println("Errore: " + e.getMessage());
} finally {
    System.out.println("Blocco finally eseguito comunque");
}
```

**Blocco** `try`: contiene **il codice che potrebbe generare una o più eccezioni**. Se **nessuna eccezione** si verifica, il blocco `try` viene eseguito fino alla fine (e poi, se presente anche il `finally`). Se si verifica un’**eccezione**, l’esecuzione del blocco `try` si interrompe nel punto dell’errore, e il controllo passa al `catch` corrispondente.

**Blocco** `catch`: blocco che intercetta e gestisce l’eccezione. È possibile usare più blocchi `catch` per gestire eccezioni diverse:

```java
try {
    // codice
} catch (IOException e) {
    // gestione IOException
} catch (NumberFormatException e) {
    // gestione NumberFormatException
}
```

**Blocco** `finally`: blocco opzionale eseguito **sempre**, anche in presenza di `return` o eccezione. Serve per **rilasciare risorse**, come file, connessioni, oggetti di rete.

---
#### Declare 

Se non si vuole gestire l’eccezione nel metodo, si può **dichiarare** che il metodo può lanciarla, tramite la parola chiave `throws`.

**Esempio:**

```java
public void parse(String data) throws ParseException {
    DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
    df.parse(data);
}
```

Serve a **propagare l’eccezione** al **chiamante** del metodo, che dovrà a sua volta gestirla o dichiararla. Quindi, chi chiama `parse` dovrà a sua volta **gestire o dichiarare** la stessa eccezione. Se la catena di chiamate continua fino al `main`, allora sarà il `main` a gestirla o dichiararla.

---
### CREARE UN'ECCEZIONE PERSONALIZZATA

Creare una **eccezione personalizzata** in Java significa definire una nuova **classe che estende `Exception`** (checked) o `RuntimeException` (unchecked), in base a se vuoi che sia una **checked exception** o una **unchecked exception**.

**Creare una checked exception** (catch or declare):

**Esempio**

```java
public class MiaCheckedException extends Exception {
    
    public MiaCheckedException() {
        super(); // chiama il costruttore di Exception
    }

    public MiaCheckedException(String message) {
        super(message); // passa il messaggio all'eccezione
    }

    public MiaCheckedException(String message, Throwable cause) {
        super(message, cause);
    }
}
```

**Uso:**

```java
public void operazione() throws MiaCheckedException {
    throw new MiaCheckedException("Verificato un errore controllato");
}
```

Chi chiama `operazione()` **deve gestire o dichiarare** l’eccezione.

---

