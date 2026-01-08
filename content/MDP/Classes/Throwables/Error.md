In Java, un **`Error`** è una sottoclasse della classe [[Throwable]] che rappresenta **problemi gravi a livello di sistema o ambiente di esecuzione**, tipicamente **non recuperabili** dall'applicazione. Gli oggetti di tipo `Error` vengono lanciati dalla **Java Virtual Machine (JVM)** quando si verificano condizioni **critiche o anomale** che rendono impossibile proseguire l'esecuzione del programma in modo affidabile.

>**Package**: [[JDK Packages#**`java.lang`**|java.lang]]

---
### CARATTERISTICHE PRINCIPALI

**Derivano da `Throwable`** ma non sono [[Exception|eccezioni]]:
**Non vanno catturati con `try-catch`**: tecnicamente è possibile farlo, ma è **sconsigliato**, perché nasconderebbe problemi gravi invece di farli emergere.
**Non vanno dichiarati con `throws`**: non è necessario (né utile) dichiarare che un metodo può lanciare un `Error`.
**Sono in genere irrecuperabili**: l'applicazione non dovrebbe tentare di gestirli, ma piuttosto **prevenirli**.

---
### ESEMPI COMUNI DI `Error`

|Tipo di `Error`|Descrizione|
|---|---|
|`OutOfMemoryError`|La JVM ha esaurito la memoria heap|
|`StackOverflowError`|Stack troppo profondo (es. ricorsione infinita)|
|`NoClassDefFoundError`|La JVM non riesce a trovare una classe al momento dell'esecuzione|
|`InternalError`|Errore interno alla JVM|
|`VirtualMachineError`|Errore critico legato alla macchina virtuale|

**Esempio:**

```java
public class Test {
    public static void main(String[] args) {
        causeStackOverflow();
    }

    public static void causeStackOverflow() {
        causeStackOverflow(); // Ricorsione infinita
    }
}
```

Questo codice produce un `StackOverflowError`, che **non andrebbe catturato**, ma evitato correggendo il codice.

---