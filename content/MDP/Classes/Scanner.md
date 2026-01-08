La classe **`Scanner`** è utilizzata per leggere input da varie fonti, come **console**, **file**, o **stringhe**. È molto usata per acquisire dati da tastiera in programmi interattivi.  
Supporta la lettura di vari tipi di dati (stringhe, numeri, booleani, ecc.) e suddivide l'input in **token** in base a delimitatori (di default, spazi bianchi).

>**Package**: [[JDK Packages#**`java.util`**|java.util]]

---
### CARATTERISTICHE PRINCIPALI

Può leggere dati da: `System.in`, file (`File`), stringhe (`String`), stream (`InputStream`).
Divide il testo in **token** usando un delimitatore (default: spazi bianchi).
Fornisce metodi **specifici** per diversi tipi di dati (`nextInt()`, `nextDouble()`, ecc.).
È **bloccante**: il programma attende finché l’input non è disponibile.

---
### METODI PRINCIPALI

| Metodo                             | Descrizione                                              |
| ---------------------------------- | -------------------------------------------------------- |
| `next()`                           | Legge il prossimo token come `String` (senza spazi).     |
| `nextLine()`                       | Legge l’intera riga fino al ritorno a capo.              |
| `nextInt()`                        | Legge il prossimo token come `int`.                      |
| `nextDouble()`                     | Legge il prossimo token come `double`.                   |
| `nextBoolean()`                    | Legge il prossimo token come `boolean`.                  |
| `hasNext()`                        | Ritorna `true` se esiste un altro token.                 |
| `hasNextInt()` / `hasNextDouble()` | Controllano se il prossimo token è del tipo specificato. |
| `useDelimiter(String pattern)`     | Cambia il delimitatore di tokenizzazione.                |
| `close()`                          | Chiude lo scanner e la risorsa associata.                |

---
### ESEMPIO

```java
import java.util.Scanner;

public class EsempioScanner {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in); // Lettura da tastiera

        System.out.print("Inserisci il tuo nome: ");
        String nome = scanner.nextLine();

        System.out.print("Inserisci la tua età: ");
        int eta = scanner.nextInt();

        System.out.println("Ciao " + nome + ", hai gia" + eta + " anni.");

        scanner.close(); // Chiusura
    }
}
```

**Output possibile:**

```yaml
Inserisci il tuo nome: Giulio # input da tastiera
Inserisci la tua età: 20 # input da tastiera
Ciao Giulio, hai gia 20 anni.
```

---