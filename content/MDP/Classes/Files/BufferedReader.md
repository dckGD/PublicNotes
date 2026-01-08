La classe `BufferedReader` di Java è utilizzata per leggere testo da un flusso di input (ad esempio un file) in modo efficiente.  
Utilizza un **[[Buffer]] interno** per ridurre il numero di accessi diretti alla sorgente di dati, migliorando le prestazioni rispetto alla lettura carattere per carattere.

>**Package**: [[JDK Packages#**`java.io`**|java.io]]
>**Estende:** [[Reader]]

---
### CARATTERISTICHE PRINCIPALI

Legge dati **testuali** (non binari).
Supporta la **lettura di linee complete** tramite il metodo `readLine()`.
Migliora le prestazioni rispetto a `FileReader` puro grazie al buffer interno.
Richiede di essere chiuso (`close()`) dopo l'uso per liberare le risorse.
Può essere concatenato (wrapping) con altre classi di lettura come `FileReader`.

---
### METODI PRINCIPALI

|Metodo|Descrizione|
|---|---|
|`read()`|Legge un singolo carattere (ritorna `int`, -1 se fine file).|
|`read(char[] cbuf, int off, int len)`|Legge un numero di caratteri in un array.|
|`readLine()`|Legge una linea di testo (senza il terminatore di linea), ritorna `null` a fine file.|
|`ready()`|Verifica se il flusso è pronto per essere letto.|
|`close()`|Chiude il flusso e rilascia le risorse.|

---
### ESEMPIO

```java
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class LeggiFileBuffered {
    public static void main(String[] args) {
        try (BufferedReader br = new BufferedReader(new FileReader("file.txt"))) {
            String linea;
            while ((linea = br.readLine()) != null) {
                System.out.println(linea);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

---