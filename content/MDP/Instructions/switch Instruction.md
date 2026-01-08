L'istruzione `switch` è una struttura di controllo che permette di eseguire **diversi blocchi di codice in base al valore di una variabile**.  
È un'alternativa più pulita e leggibile rispetto a una serie di `if-else if-else`, specialmente quando si confrontano più valori di una stessa variabile.

---

La **sintassi** dell'`switch`è la seguente:
(guarda anche la sintassi semplificata a [[switch Instruction#^6b5d47|fine pagina]])

```java
switch (espressione) {
    case valore1:
        // Blocco di codice eseguito se espressione == valore1
        break;
    case valore2:
        // Blocco di codice eseguito se espressione == valore2
        break;
    default:
        // Blocco di codice eseguito se nessun valore corrisponde
}
```

- `espressione` deve essere un valore intero, un carattere, una stringa o un'enumerazione (`enum`).
- ogni `case` rappresenta un possibile valore dell'espressione.
- `break` impedisce che il codice continui ad eseguire i casi successivi.
- `default` è opzionale e viene eseguito se nessun `case` corrisponde.

**Ad esempio:**

```java
public class SwitchExample {
    public static void main(String[] args) {
        int giorno = 3;
        switch (giorno) {
            case 1:
                System.out.println("Lunedì");
                break;
            case 2:
                System.out.println("Martedì");
                break;
            case 3:
                System.out.println("Mercoledì");
                break;
            case 4:
                System.out.println("Giovedì");
                break;
            case 5:
                System.out.println("Venerdì");
                break;
            case 6:
                System.out.println("Sabato");
                break;
            case 7:
                System.out.println("Domenica");
                break;
            default:
                System.out.println("Numero non valido");
        }
    }
}
//Output: "Mercoledì"
```

---

Possiamo **raggruppare più `case`** con lo stesso comportamento:

**Ad esempio:**

```java
public class SwitchMultipleCase {
    public static void main(String[] args) {
        int mese = 4;
        switch (mese) {
            case 12: case 1: case 2:
                System.out.println("Inverno");
                break;
            case 3: case 4: case 5:
                System.out.println("Primavera");
                break;
            case 6: case 7: case 8:
                System.out.println("Estate");
                break;
            case 9: case 10: case 11:
                System.out.println("Autunno");
                break;
            default:
                System.out.println("Mese non valido");
        }
    }
}
//Output: "Primavera"
```

---

Dal **Java 14**, è possibile usare la nuova sintassi con frecce (`->`), che semplifica il codice: ^6b5d47

```java
public class SwitchArrowExample {
    public static void main(String[] args) {
        int giorno = 2;
        switch (giorno) {
            case 1 -> System.out.println("Lunedì");
            case 2 -> System.out.println("Martedì");
            case 3 -> System.out.println("Mercoledì");
            default -> System.out.println("Giorno non valido");
        }
    }
}
//Output: "Martedì"
```

**Vantaggi:**

- Più leggibile
- Niente `break` necessario (si comporta automaticamente come se avesse `break`)

---