L'istruzione `if` in Java permette di eseguire un blocco di codice **solo se** una determinata condizione è vera.  
È uno dei costrutti fondamentali per il controllo del flusso di esecuzione in un programma.

---

La **sintassi** è la seguente:

```java
if (condizione) {
    // Blocco eseguito se la condizione è vera
} else {
    // Blocco eseguito se la condizione è falsa
}
```

**Ad esempio:**

```java
public class IfElseExample {
    public static void main(String[] args) {
        int numero = 7;
        if (numero > 11) {
            System.out.println("Il numero è maggiore di 11");
        } else {
            System.out.println("Il numero NON è maggiore di 11");
        }
    }
}
//Output: Il numero NON è maggiore di 11
```

---

Se vogliamo controllare più condizioni, possiamo usare `else if` tra `if` ed `else`:

```java
if (condizione1) {
    // Codice eseguito se condizione1 è vera
} else if (condizione2) {
    // Codice eseguito se condizione1 è falsa ma condizione2 è vera
} else {
    // Codice eseguito se nessuna condizione è vera
}
```

**Ad esempio:**

```java
public class ElseIfExample {
    public static void main(String[] args) {
        int numero = 0;
        if (numero > 0) {
            System.out.println("Il numero è positivo");
        } else if (numero < 0) {
            System.out.println("Il numero è negativo");
        } else {
            System.out.println("Il numero è zero");
        }
    }
}
//Output: Il numero è zero
```

---