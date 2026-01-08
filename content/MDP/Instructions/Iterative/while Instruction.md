L'istruzione `while` in Java è una **struttura di controllo iterativa** che permette di **eseguire un blocco di codice finché una condizione è vera**.
Viene utilizzata quando **non sappiamo in anticipo quante volte eseguire il ciclo**, ma solo che deve continuare fino a quando una certa condizione rimane vera.

---

La **sintassi** di un ciclo `while` è la seguente:

```java
while (condizione) {
    // Blocco di codice eseguito finché la condizione è vera
}
```

- **`condizione`**: è un'espressione booleana (true/false).
- **Se è vera (`true`)**, il codice all'interno del ciclo viene eseguito.
- **Se è falsa (`false`)**, il ciclo termina.

**Ad esempio:**

```java
public class WhileExample {
    public static void main(String[] args) {
        int numero = 1; // Inizializzazione della variabile
        while (numero <= 5) {  // Condizione
            System.out.println("Numero: " + numero);
            numero++; // Incremento per evitare un ciclo infinito
        }
    }
}
/* Output: 
Numero: 1  
Numero: 2  
Numero: 3  
Numero: 4  
Numero: 5 */
```

---

Esiste una variante del `while` chiamata **`do-while`**, che garantisce che il codice venga eseguito **almeno una volta**, anche se la condizione è falsa, infatti la condizione è posta alla fine.

**Sintassi** del `do-while`:

```java
do {
    // Blocco di codice eseguito almeno una volta
} while (condizione);
```

---

Possiamo interrompere un ciclo con `break` quando una certa condizione è soddisfatta.

**Ad esempio:**

```java
public class WhileBreakExample {
    public static void main(String[] args) {
        int numero = 1;
        while (true) {  // Ciclo infinito
            System.out.println("Numero: " + numero);
            if (numero == 5) {
                break;  // Esce dal ciclo quando numero è 5
            }
            numero++;
        }
        System.out.println("Ciclo terminato.");
    }
}
/* Output: 
Numero: 1  
Numero: 2  
Numero: 3  
Numero: 4  
Numero: 5 */
```

---

L'istruzione `continue` **salta il resto del codice e passa all'iterazione successiva**.

**Ad esempio:**

```java
public class WhileContinueExample {
    public static void main(String[] args) {
        int numero = 0;
        while (numero < 5) {
            numero++;
            if (numero == 3) {
                continue;  // Salta il numero 5
            }
            System.out.println("Numero: " + numero);
        }
    }
}
/* Output: 
Numero: 1  
Numero: 2  
Numero: 4  
Numero: 5 */
```

---