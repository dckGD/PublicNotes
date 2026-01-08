Un programma Java è costituito da diverse parti fondamentali. Ecco la struttura base:

```java
// 1. Dichiarazione del pacchetto (opzionale)
package nome_del_pacchetto;

// 2. Importazione delle librerie (opzionale)
import java.util.Scanner;  // Importa la classe Scanner per input da tastiera

// 3. Dichiarazione della classe principale
public class NomeClasse {
    
    // 4. Metodo principale (entry point del programma)
    public static void main(String[] args) {
        // Corpo del programma
        System.out.println("Ciao, mondo!"); // Stampa un messaggio a video
    }
}
```

**Dettagli delle sezioni:**

**Dichiarazione del package (opzionale):** Se il programma fa parte di un pacchetto, va dichiarato con `package nome_pacchetto;` all'inizio del file.

**Importazione delle librerie** (opzionale): Per utilizzare classi definite in altri pacchetti, si usa `import nome_pacchetto.NomeClasse;`.

**Dichiarazione della classe principale**: In Java, tutto il codice deve essere all'interno di una classe. Il nome della classe deve coincidere con il nome del file `.java`.

**Metodo `main`**: È il punto di ingresso del programma. Il codice all'interno di `main` viene eseguito all'avvio.

---