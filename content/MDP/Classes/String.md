La classe `String` in Java rappresenta una sequenza immutabile di caratteri Unicode. Poiché è immutabile, ogni operazione che sembra modificare una stringa in realtà crea un nuovo oggetto `String`.

>**Package**: [[JDK Packages#**`java.lang`**|java.lang]]

---
### CARATTERISTICHE PRINCIPALI

**Immutabilità**: una volta creata, una `String` non può essere modificata.
**Archiviazione interna**: memorizza i caratteri in un array interno (`char[]` fino a Java 8, `byte[]` da Java 9).
**Pool delle stringhe** (_String Pool_): le stringhe letterali vengono memorizzate in un’area speciale di memoria per ottimizzare l’uso della RAM e migliorare le prestazioni.
**Supporto Unicode**: ogni carattere è rappresentato secondo lo standard Unicode.
**Metodi ricchi**: la classe offre numerosi metodi per ricerca, confronto, manipolazione e conversione.
**Implementa interfacce**: `Serializable`, `Comparable<String>`, `CharSequence`.

---
### DICHIARAZIONE E CREAZIONE

In Java, le stringhe sono rappresentate dalla classe `String`. Esistono due modi per dichiarare una stringa:
#### Creazione tramite letterali

```java
String testo = "Non scrivere mentre guidi, non rischiare";
```

Quando si assegna una stringa in questo modo, Java la memorizza nel **[[Strings Pool|pool di stringhe]]** per ottimizzare la gestione della memoria.
#### Creazione con il costruttore

```java
String altraStringa = new String("Non scrivere mentre guidi");
```

Questo crea un nuovo oggetto `String` nella memoria heap, senza utilizzare il pool di stringhe.

---
### METODI PRINCIPALI 

|Metodo|Descrizione|
|---|---|
|`length()`|Restituisce la lunghezza della stringa.|
|`charAt(int index)`|Restituisce il carattere alla posizione specificata.|
|`substring(int beginIndex, int endIndex)`|Restituisce una sottostringa.|
|`equals(Object obj)`|Confronta il contenuto di due stringhe.|
|`equalsIgnoreCase(String another)`|Confronta ignorando maiuscole/minuscole.|
|`compareTo(String another)`|Confronta due stringhe in ordine lessicografico.|
|`startsWith(String prefix)` / `endsWith(String suffix)`|Verifica se la stringa inizia o termina con una determinata sequenza.|
|`contains(CharSequence s)`|Controlla se la stringa contiene una sottosequenza.|
|`toUpperCase()` / `toLowerCase()`|Converte in maiuscolo/minuscolo.|
|`trim()`|Rimuove spazi iniziali e finali.|
|`replace(CharSequence target, CharSequence replacement)`|Sostituisce tutte le occorrenze di una sottostringa.|
|`split(String regex)`|Divide la stringa in base a un'espressione regolare.|

---
### CONCATENAZIONE DI STRINGHE

La concatenazione può essere fatta con l'operatore `+` oppure con il metodo `concat()`.

```java
String nome = "Giulio";
String saluto = "Ciao, " + nome + "!";
System.out.println(saluto); // Output: "Ciao, Giulio!"
```

Oppure:

```java
String fraseCompleta = "Ciao, ".concat(nome);
System.out.println(fraseCompleta); // Output: "Ciao, Giulio"
```

---
### STRINGBUILDER E STRINGBUFFER

Poiché le stringhe sono immutabili, per modifiche frequenti è meglio usare `StringBuilder` o `StringBuffer`.
#### StringBuilder (più veloce, non thread-safe)

```java
StringBuilder sb = new StringBuilder("Vado sempre,");
sb.append(" sempre al Burger King");
System.out.println(sb.toString()); // "Vado sempre, sempre al Burger King"
```
#### StringBuffer (thread-safe, leggermente più lento)

```java
StringBuffer sb = new StringBuffer("Vado sempre,");
sb.append(" sempre al Burger King");
System.out.println(sb.toString()); // "Vado sempre, sempre al Burger King"
```

---
### ESEMPIO

```java
public class Main {
    public static void main(String[] args) {
        String nome = "Ma Fareshi";

        // Lunghezza
        System.out.println("Lunghezza: " + nome.length());

        // Accesso a carattere
        System.out.println("Primo carattere: " + nome.charAt(0));

        // Sottostringa
        System.out.println("Substring(3, 6): " + nome.substring(3, 6));

        // Confronto
        System.out.println("Uguale a 'Poppin'? " +nome.equals("Poppin"));

        // Conversione
        System.out.println("Maiuscolo: " + nome.toUpperCase());

        // Sostituzione
        String nuova = nome.replace("Fareshi", "Boss");
        System.out.println("Sostituzione: " + nuova);

        // Divisione
        String[] parole = nome.split(" ");
        System.out.println("Prima parola: " + parole[0]);
    }
}

```

**Output:**

```yaml
Lunghezza: 10
Primo carattere: M
Substring(3, 6): Far
Uguale a 'Poppin'? false
Maiuscolo: MA FARESHI
Sostituzione: Ma Boss
Prima parola: Ma
```

---