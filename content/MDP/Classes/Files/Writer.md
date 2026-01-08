La classe `Writer` è la [[Classes#SUPERCLASSE E SOTTOCLASSE|superclasse]] astratta per tutte le classi che scrivono flussi di caratteri in Java e definisce l'interfaccia di base per la scrittura di dati testuali. Non può essere istanziata direttamente, ma viene estesa da classi concrete come [[FileWriter]], [[BufferedWriter]].

>**Package**: [[JDK Packages#**`java.io`**|java.io]]

---
### CARATTERISTICHE PRINCIPALI

Classe **[[Classes#CLASSE ASTRATTA|astratta]]**.
Fornisce metodi per scrivere caratteri, array di caratteri e stringhe.
Può essere estesa per creare writer specializzati.
Supporta la scrittura **sincrona** (senza [[Buffer]], a meno che non venga estesa).
Ha metodi per scrivere, chiudere, e svuotare (flush) il flusso.

---
### METODI PRINCIPALI

|Metodo|Descrizione|
|---|---|
|`write(int c)`|Scrive un singolo carattere.|
|`write(char[] cbuf)`|Scrive un array di caratteri completo.|
|`write(char[] cbuf, int off, int len)`|Scrive una porzione di array di caratteri.|
|`write(String str)`|Scrive una stringa.|
|`write(String str, int off, int len)`|Scrive una porzione di stringa.|
|`flush()`|Svuota il buffer e forza la scrittura fisica.|
|`close()`|Chiude lo stream e rilascia le risorse.|

---
### ESEMPIO

```java
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;

public class WriterExample {
    public static void main(String[] args) {
        try (Writer writer = new FileWriter("output.txt")) {
            writer.write("Ciao, mondo!");
            writer.flush();  // Assicura che tutto sia scritto su file
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

> `FileWriter` estende `Writer`

---