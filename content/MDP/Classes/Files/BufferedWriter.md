La classe **`BufferedWriter`** serve a scrivere testo in un flusso di output in modo efficiente, utilizzando un **[[Buffer]] interno** per ridurre il numero di operazioni di I/O sul disco o su altre destinazioni.  
Avvolge un oggetto `Writer` esistente (come [[FileWriter]]), aggiungendo buffering e metodi utili per scrivere testo e andare a capo.

>**Package**: [[JDK Packages#**`java.io`**|java.io]]
>**Estende:** [[Writer]]

---
### CARATTERISTICHE PRINCIPALI

Estende la classe **`Writer`**.
Utilizza un **buffer interno** (di default 8192 caratteri) per ridurre accessi diretti alla risorsa.
Migliora le prestazioni rispetto a `FileWriter` o `OutputStreamWriter` senza buffer.
Consente scrittura di stringhe, array di caratteri e singoli caratteri.
Include il metodo `newLine()` per aggiungere una nuova riga indipendentemente dal sistema operativo.
Deve essere **chiuso** (`close()`) o **flushato** (`flush()`) per assicurare che i dati siano scritti.

---
### METODI PRINCIPALI

|Metodo|Descrizione|
|---|---|
|`write(int c)`|Scrive un singolo carattere.|
|`write(char[] cbuf, int off, int len)`|Scrive una porzione di array di caratteri.|
|`write(String s)`|Scrive una stringa intera.|
|`newLine()`|Inserisce un separatore di riga corretto per il sistema operativo.|
|`flush()`|Forza la scrittura del buffer sull’output.|
|`close()`|Chiude lo stream e libera le risorse.|

---
### ESEMPIO

```java
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

public class EsempioBufferedWriter {
    public static void main(String[] args) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter("output.txt"))) {
            bw.write("Ciao mondo!");
            bw.newLine(); // va a capo
            bw.write("Scrittura con buffering.");
            bw.flush(); // forziamo la scrittura
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

---