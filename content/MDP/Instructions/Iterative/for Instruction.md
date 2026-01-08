Il ciclo `for` è una delle strutture di controllo più usate in Java e permette di **ripetere un blocco di codice un numero definito di volte** (guarda anche il for-each).
Viene utilizzato quando **conosciamo in anticipo quante volte eseguire il ciclo**.

---

La **sintassi** di un ciclo `for` è la seguente:

```java
for (inizializzazione; condizione; incremento/decremento) {
    // Blocco di codice eseguito ad ogni iterazione
}
```

- **Inizializzazione**: Dichiarazione e assegnazione della variabile di controllo del ciclo (es. `int i = 0;`).
- **Condizione**: Il ciclo continua finché questa espressione è vera (es. `i < 5;`).
- **Incremento/Decremento**: Modifica della variabile di controllo (es. `i++` per aumentare di 1).

**Ad esempio:**

```java
public class ForExample {
    public static void main(String[] args) {
        for (int i = 1; i <= 5; i++) {  
            System.out.println("Numero: " + i);
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

Esiste una variante del `for`, detta **for-each**, per scorrere direttamente gli elementi di un array o di una [[Collection|collezione]]: ^3e8bd6

```java
for (TipoVariabile nomeVariabile : arrayOCollezione) {
    // Blocco di codice eseguito per ogni elemento
}
```

- **`TipoVariabile`** → Il tipo degli elementi nell'array o nella collezione.
- **`nomeVariabile`** → Il nome della variabile temporanea che assume il valore di ogni elemento.
- **`arrayOCollezione`** → L'array o la collezione su cui iterare.

**Ad esempio:**

```java
public class ForEachExample {
    public static void main(String[] args) {
        int[] numeri = {10, 20, 30, 40, 50};
        for (int numero : numeri) {  // Scorre gli elementi direttamente
            System.out.println("Numero: " + numero);
        }
    }
}
/* Output: 
Numero: 10  
Numero: 20  
Numero: 30  
Numero: 40  
Numero: 50 */
```

---

L'istruzione `break` interrompe il ciclo in base a una condizione.

```java
public class ForBreakExample {
    public static void main(String[] args) {
        for (int i = 1; i <= 10; i++) {
            if (i == 5) {
                System.out.println("Interruzione del ciclo");
                break;  // Esce dal ciclo quando i è 5
            }
            System.out.println("Numero: " + i);
        }
    }
}
/* Output: 
Numero: 1  
Numero: 2  
Numero: 3  
Numero: 4  
Interruzione del ciclo */
```

---

L'istruzione `continue` **salta** un'iterazione del ciclo.

```java
public class ForContinueExample {
    public static void main(String[] args) {
        for (int i = 1; i <= 5; i++) {
            if (i == 3) {
                System.out.println("Salto il numero 3");
                continue;  // Salta questa iterazione
            }
            System.out.println("Numero: " + i);
        }
    }
}
/* Output:  
Numero: 1  
Numero: 2  
Salto il numero 3  
Numero: 4  
Numero: 5 */
```

---

Possiamo usare cicli `for` annidati.

**Ad esempio:**

```java
public class ForNestedExample {
    public static void main(String[] args) {
        for (int i = 1; i <= 3; i++) {  // Ciclo esterno
            for (int j = 1; j <= 2; j++) {  // Ciclo interno
                System.out.println("i: " + i + ", j: " + j);
            }
        }
    }
}
/* Output: 
i: 1, j: 1  
i: 1, j: 2  
i: 2, j: 1  
i: 2, j: 2  
i: 3, j: 1  
i: 3, j: 2 */
```

---
