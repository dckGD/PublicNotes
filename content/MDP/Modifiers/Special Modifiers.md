I modificatori speciali modificano il comportamento predefinito delle variabili, dei metodi e delle classi in Java.
### FINAL (COSTANTE)

Il valore non può essere modificato dopo l'assegnazione iniziale.

```java
final int COSTANTE = 100;
```

---
### STATIC (VARIABLE DI CLASSE)

Appartiene alla classe (stesso valore per tutti gli oggetti della classe) e non alle singole [[Instance|istanze]].

```java
static int contatore = 0;
```

---
### VOLATILE (MULTITHREADING)

Garantisce che il valore sia sempre aggiornato tra i [[Multithreading|thread]].

```java
volatile boolean running = true;
```

---
#### TRANSIENT (SERIALIZZAZIONE)

Esclude la variabile dalla [[Serialization|serializzazione]].

```java
transient int datiSensibili;
```

---
