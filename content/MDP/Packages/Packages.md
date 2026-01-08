In **Java**, un **package** è un meccanismo per organizzare le classi e le interfacce in gruppi logici. Serve per evitare conflitti tra nomi di classi e per migliorare la modularità e la manutenibilità del codice.

---
### TIPOLOGIE DI PACKAGE

I package in Java possono essere di due tipi:

1. **Package predefiniti**: forniti dalla libreria standard di Java ([[JDK Packages]])
2. **Package personalizzati**: creati dallo sviluppatore per organizzare meglio il codice.

---
### COME CREARE UN PACKAGE

Per creare un package personalizzato, si utilizza la parola chiave `package` all'inizio del file Java. Ad esempio:

```java
package mioPacchetto; // Definizione del package

public class MiaClasse {
    public void saluta() {
        System.out.println("Ciao dal package mioPacchetto!");
    }
}
```

Per compilare ed eseguire il file:

```sh
javac -d . MiaClasse.java  # Compila creando la struttura delle cartelle
java mioPacchetto.MiaClasse  # Esegue la classe specificando il package
```

---
### COME IMPORTARE UN PACKAGE

Per usare una classe contenuta in un altro package, è necessario importarlo con `import`

```java
import mioPacchetto.MiaClasse; // Importa la classe MiaClasse

public class Main {
    public static void main(String[] args) {
        MiaClasse obj = new MiaClasse();
        obj.saluta();
    }
}
```

Se si vuole importare tutte le classi di un package, puoi usare `*`:

```java
import mioPacchetto.*;
```

---