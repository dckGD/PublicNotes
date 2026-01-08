La classe **`FileReader`** è un **flusso di input per leggere caratteri** da un file.  
Fa parte delle classi del package **`java.io`** e fornisce un modo semplice per leggere file di testo, convertendo automaticamente i byte in caratteri secondo la codifica predefinita del sistema (o una specificata).

>**Package**: [[JDK Packages#**`java.io`**|java.io]]
>**Estende:** `InputStreamReader` che a sua volta estende [[Reader]]

---
### CARATTERISTICHE PRINCIPALI

Specializzata nella **lettura di testo** da file.
Converte automaticamente byte → caratteri.
Può essere usata da sola o combinata con [[BufferedReader]] per maggiore efficienza.
Supporta percorsi relativi e assoluti.
Non adatta per file binari (usare `FileInputStream` in quel caso).

---
### METODI PRINCIPALI

|Metodo|Descrizione|
|---|---|
|`int read()`|Legge un singolo carattere e restituisce il suo valore Unicode, oppure `-1` se raggiunta la fine del file.|
|`int read(char[] cbuf)`|Legge caratteri in un array e restituisce il numero di caratteri letti.|
|`int read(char[] cbuf, int off, int len)`|Legge fino a `len` caratteri in un array a partire dall'indice `off`.|
|`void close()`|Chiude il flusso e rilascia le risorse.|
|`boolean ready()`|Restituisce `true` se il flusso è pronto per la lettura senza bloccare.|

---
### ESEMPIO

```java
import java.io.FileReader;
import java.io.IOException;

public class FileReaderExample {
    public static void main(String[] args) {
        try (FileReader reader = new FileReader("esempio.txt")) {
            int carattere;
            while ((carattere = reader.read()) != -1) {
                System.out.print((char) carattere);
            }
        } catch (IOException e) {
            System.out.println("Errore durante la lettura del file.");
            e.printStackTrace();
        }
    }
}
```

---