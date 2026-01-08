La classe **`File`** rappresenta un’**astrazione di un percorso di file o directory** nel file system. Non gestisce direttamente la lettura o scrittura dei contenuti, ma fornisce metodi per creare, eliminare, rinominare file o directory e per ottenere informazioni su di essi (dimensioni, percorso, permessi, ecc.).

>**Package**: [[JDK Packages#**`java.io`**|java.io]]

---
### CARATTERISTICHE PRINCIPALI

Può rappresentare sia **file** che **directory**.
Supporta percorsi relativi e assoluti.
Non apre il file per la lettura/scrittura (serve solo a rappresentarlo).
Compatibile con sistemi operativi diversi (gestisce separatori di percorso `File.separator`).

---
### METODI PRINCIPALI

|Metodo|Descrizione|
|---|---|
|`exists()`|Restituisce `true` se il file o directory esiste.|
|`createNewFile()`|Crea un nuovo file vuoto.|
|`delete()`|Elimina il file o directory.|
|`getName()`|Restituisce il nome del file/directory.|
|`getAbsolutePath()`|Restituisce il percorso assoluto.|
|`getPath()`|Restituisce il percorso così come fornito nel costruttore.|
|`length()`|Restituisce la dimensione del file (in byte).|
|`isFile()`|Restituisce `true` se è un file normale.|
|`isDirectory()`|Restituisce `true` se è una directory.|
|`list()`|Restituisce un array di stringhe con i nomi dei file nella directory.|
|`listFiles()`|Restituisce un array di oggetti `File` contenenti i file della directory.|
|`mkdir()`|Crea una directory.|
|`mkdirs()`|Crea directory intermedie necessarie.|

---
### ESEMPIO

```java
import java.io.File;
import java.io.IOException;

public class FileExample {
    public static void main(String[] args) {
        try {
            // Creazione oggetto File
            File file = new File("esempio.txt");

            // Creazione fisica del file se non esiste
            if (file.createNewFile()) {
                System.out.println("File creato: " + file.getName());
            } else {
                System.out.println("Il file esiste già.");
            }

            // Informazioni sul file
            System.out.println("Percorso assoluto: " + file.getAbsolutePath());
            System.out.println("Dimensione: " + file.length() + " byte");
            System.out.println("È un file? " + file.isFile());
            System.out.println("È una directory? " + file.isDirectory());

        } catch (IOException e) {
            System.out.println("Si è verificato un errore.");
            e.printStackTrace();
        }
    }
}
```

---