La classe **`FileWriter`** serve per **scrivere caratteri** (non byte) in un file.  
È un **writer** orientato ai caratteri, quindi adatto per testi, non per dati binari.  
Supporta sia la **creazione di nuovi file** che la **scrittura su file esistenti**, con possibilità di **append**.

>**Package**: [[JDK Packages#**`java.io`**|java.io]]
>**Estende:** `OutputStreamWriter` che a sua volta estende [[Writer]]

---
### CARATTERISTICHE PRINCIPALI

Scrive **dati di tipo `char`**, `String` o array di caratteri in un file.
Può **sovrascrivere** il contenuto esistente o **aggiungere** (append) in fondo.
Può essere usato insieme a [[BufferedWriter]] per migliorare le prestazioni.
Richiede la gestione delle **eccezioni** (`IOException`).
È uno **stream orientato ai caratteri**, quindi converte i caratteri in byte usando la codifica predefinita della JVM.

---
### METODI PRINCIPALI

|Metodo|Descrizione|
|---|---|
|`FileWriter(String fileName)`|Crea un writer per il file indicato (sovrascrive se esiste).|
|`FileWriter(String fileName, boolean append)`|Crea un writer per il file indicato, con possibilità di **append**.|
|`write(int c)`|Scrive un singolo carattere.|
|`write(String str)`|Scrive una stringa completa.|
|`write(char[] cbuf)`|Scrive un array di caratteri.|
|`flush()`|Forza la scrittura di tutti i dati nel file.|
|`close()`|Chiude il writer e rilascia le risorse.|

---
### ESEMPIO

```java
import java.io.FileWriter;
import java.io.IOException;

public class Main {
    public static void main(String[] args) {
        try {
            // Crea un FileWriter in modalità append
            FileWriter writer = new FileWriter("output.txt", true);

            writer.write("Ciao, mondo!\n");
            writer.write("Scrittura con FileWriter.\n");

            writer.flush(); // Forza la scrittura immediata
            writer.close(); // Chiude il file

            System.out.println("Scrittura completata con successo.");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

---