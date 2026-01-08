Una **lambda expression** è una funzione anonima: non ha un nome, ma ha **parametri**, **corpo** e può **ritornare un valore**.

Tali espressioni creano oggetti anonimi assegnabili a riferimenti a [[Classes#Interfaccia funzionale|interfacce funzionali]] compatibili con l’intestazione (input/output) della funzione creata.

>È stata introdotta in **Java 8** per rendere il codice più conciso, specialmente con le nuove **Stream API** e la programmazione funzionale.

---
### SINTASSI

```java
(parametri) -> { corpo }
```

**Alcune varianti ricorrenti:**

|Forma|Esempio|Quando si usa|
|---|---|---|
|Nessun parametro|`() -> System.out.println("Ciao")`|Come `Runnable`|
|Un parametro senza tipo|`x -> x * x`|Tipo dedotto|
|Più parametri con tipo|`(int a, int b) -> a + b`|Facoltativo specificare il tipo|
|Corpo con una sola istruzione|`(x, y) -> x + y`|Il valore è restituito implicitamente|
|Corpo con blocco `{}`|`(x, y) -> { return x + y; }`|Necessario per più istruzioni|

**Esempi:**

>In questi esempi, le interfacce funzionali sono quasi sempre del [[Classes#^217d6d|pacchetto]] (da java 8 in poi) `java.util.function`(quelle in cui non si specifica la definizione dell'interfaccia sopra):

**Runnable (nessun argomento, nessun ritorno)**

```java
Runnable r = () -> System.out.println("Eseguo il thread!");
new Thread(r).start();
```

**Operazione su due numeri (es. somma)**

```java
@FunctionalInterface
interface Operazione {
    int esegui(int a, int b);
}

Operazione somma = (a, b) -> a + b;
System.out.println(somma.esegui(4, 5)); // 9
```

**Predicate (ritorna booleano)**

```java
Predicate<String> èLunga = s -> s.length() > 5;
System.out.println(èLunga.test("Java")); // false
```

**Function (trasforma un valore)**

```java
Function<String, Integer> lunghezza = s -> s.length();
System.out.println(lunghezza.apply("Ciao")); // 4
```

**Sort di collezioni con lambda**

```java
// Lambda che usa attributo direttamente
Collections.sort(persone, (a, b) -> a.eta - b.eta);

// Lambda che chiama getter
Collections.sort(persone, (a, b) -> a.getEta() - b.getEta());

// Method reference al getter
Collections.sort(persone, Comparator.comparing(Persona::getEta));
```

> Quando chiamo un metodo direttamente (getter o metodo già pronto) utilizzo una [[Method Reference]] (`::`), quando invece devo fare un calcolo o trasformazione prima di confrontare utilizzo la freccia (`->`)
---