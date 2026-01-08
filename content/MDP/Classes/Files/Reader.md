La classe`Reader` è la [[Classes#SUPERCLASSE E SOTTOCLASSE|superclasse]] astratta che fornisce un’interfaccia di base per leggere sequenze di caratteri da diverse sorgenti (file, stringhe, stream di input). Non può essere istanziata direttamente, ma viene estesa da classi concrete come [[FileReader]], [[BufferedReader]].

>**Package**: [[JDK Packages#**`java.io`**|java.io]]

---
### CARATTERISTICHE PRINCIPALI

Classe **[[Classes#CLASSE ASTRATTA|astratta]]**.
Offre metodi per leggere caratteri singoli, array di caratteri o porzioni di array.
Supporta la lettura sequenziale di caratteri.
Può essere estesa per letture specifiche da file, stream, stringhe, ecc.
Include metodi per gestire la chiusura e il flush del [[Buffer]] (se presente)    

---
### METODI PRINCIPALI

|Metodo|Descrizione|
|---|---|
|`int read()`|Legge un singolo carattere (ritorna int o -1 se EOF).|
|`int read(char[] cbuf)`|Legge caratteri in un array, ritorna quanti letti.|
|`int read(char[] cbuf, int off, int len)`|Legge fino a `len` caratteri in un array da offset `off`.|
|`long skip(long n)`|Salta fino a `n` caratteri nel flusso.|
|`boolean ready()`|Indica se il reader è pronto per la lettura senza blocco.|
|`void close()`|Chiude il reader e libera risorse.|

---
### ESEMPIO

```java
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;

public class ReaderExample {
    public static void main(String[] args) {
        try (Reader reader = new FileReader("input.txt")) {
            int data;
            while ((data = reader.read()) != -1) {
                System.out.print((char) data);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

> `FileReader` estende `Reader`

---