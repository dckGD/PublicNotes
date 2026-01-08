### TIPI PRIMITIVI

Tutti i valori in Java sono oggetti eccetto i valori primitivi. Quest'ultimi appartengono a 8 tipi primitivi che sono direttamente supportati dal linguaggio:

| Tipo      | Valori                                                        |
| --------- | ------------------------------------------------------------- |
| `byte`    | interi 8 bits: da -128 a 127                                  |
| `short`   | interi 16 bits: da -32768 a 32767                             |
| `int`     | interi 32 bits: da -2147483648 a 2147483647                   |
| `long`    | interi 64 bits: da -9223372036854775808 a 9223372036854775807 |
| `float`   | numeri in virgola mobile 32 bits (IEEE 754)                   |
| `double`  | numeri in virgola mobile 64 bits (IEEE 754)                   |
| `boolean` | `true` o `false`                                              |
| `char`    | caratteri 16-bits Unicode UTF-16                              |

---

**Valori primitivi:**

I valori dei tipi primitivi **non sono oggetti**. Sono valori "semplici" che vengono memorizzati direttamente nella memoria. Quando dichiari una variabile di tipo primitivo, il valore è immagazzinato direttamente nella variabile e viene gestito in modo molto efficiente. Esempio di variabili primitive:

```java
int numero = 11;  // Valore primitivo
char lettera = 'G';  // Valore primitivo
boolean attivo = true;  // Valore primitivo
float temperatura = 36.6f;  // Valore primitivo
double pi = 3.14159;  // Valore primitivo
long longValore = 100000L;  // Valore primitivo
```

- **Nessun [[Overhead]] di oggetto.**
- **Memoria allocata direttamente** per il valore.
- Quando assegni il valore di una variabile primitiva a un'altra variabile, **copi** il valore (assegnazione per valore).

---
### TIPI DI RIFERIMENTO

Un qualsiasi tipo che non è né primitivo né `void` è detto **tipo riferimento** (reference type). Quindi ogni tipo che ha come valori oggetti è un tipo riferimento.

---

**Valori degli oggetti:**

I valori degli oggetti sono riferimenti a oggetti. Quando crei un oggetto, la variabile non contiene direttamente i dati dell'oggetto, ma un riferimento (un "puntatore") alla posizione in memoria dove l'oggetto effettivo è memorizzato. Esempio di oggetti:

```java
String nome = "Giulio";  // Oggetto String
ArrayList<String> lista = new ArrayList<>();  // Oggetto ArrayList
```

- **Oggetti veri e propri** vengono creati nella [[Java Memory Model|heap]].
- La variabile contiene un **riferimento** all'oggetto, non il valore dell'oggetto stesso.
- Quando assegni un oggetto a un'altra variabile, **copi** il riferimento (assieme a tutte le modifiche che potrebbero essere fatte sull'oggetto).

---

**I tipi di riferimento in Java includono:**
#### Oggetti (istanze di classe)

Ogni classe che definisci in Java rappresenta un tipo di riferimento. Quando crei un oggetto di una classe, quella variabile di riferimento ha il tipo della classe. Un esempio sono le [[String|stringhe]].

---
#### Array

Gli **[[Arrays|array]]** sono un tipo di riferimento, anche se contengono tipi primitivi o oggetti.
Gli array stessi sono oggetti, quindi sono memorizzati nella [[Java Memory Model|heap]], ma gli **elementi** all'interno dell'array possono essere tipi primitivi (come `int`, `char`, ecc.) o altri oggetti.

---
#### Interfacce

Le **interfacce** sono un tipo di riferimento che definisce un contratto di metodi che devono essere implementati dalle classi che le estendono.

---
#### Enumerazioni (Enum)

Le **enumerazioni (Enum)** sono un tipo di riferimento che definisce un insieme di costanti. Ogni valore di un Enum è effettivamente un oggetto, quindi un tipo di riferimento.

---
#### Classi Wrapper per tipi primitivi

In Java, i **tipi wrapper** (o **wrapper classes**) sono classi che permettono di trattare i **tipi primitivi** come **oggetti**. Ogni tipo primitivo ha una classe wrapper associata, che fornisce funzionalità aggiuntive per manipolare il valore del tipo primitivo come un oggetto.

La conversione di un tipo primitivo al corrispondente tipo riferimento è chiamata [[Autoboxing]], mentre quella inversa, dal tipo riferimento al tipo primitivo, è chiamata [[Unboxing]].

| Tipo primitivo | Tipo riferimento |
| -------------- | ---------------- |
| `byte`         | `Byte`           |
| `short`        | `Short`          |
| `int`          | `Integer`        |
| `long`         | `Long`           |
| `float`        | `Float`          |
| `double`       | `Double`         |
| `boolean`      | `Boolean`        |
| `char`         | `Character`      |

---
#### Tipi generici (Generics)

I **tipi generici** (o **generics**) in Java permettono di scrivere codice che può funzionare con **tipi diversi** in modo **sicuro** e **riutilizzabile** senza dover ripetere il codice per ogni tipo di dato specifico. L'uso dei generici consente di creare classi, metodi e interfacce che operano su tipi di dati **astratti**, garantendo la sicurezza dei tipi a tempo di compilazione e migliorando la leggibilità e la manutenzione del codice. 

**Generics principali:**

|Tipo Generico|Descrizione|
|---|---|
|`<T>`|**T** è il parametro di tipo generico più comune. Può essere qualsiasi tipo (classe o interfaccia) scelto quando si crea l'oggetto o si invoca il metodo.|
|`<E>`|Rappresenta un **elemento** di una collezione (ad esempio, `List<E>`, `Set<E>`). Comunemente usato nelle collezioni.|
|`<K>`|Usato per rappresentare la **chiave** in una struttura dati che memorizza coppie chiave/valore, come in `Map<K, V>`.|
|`<V>`|Usato per rappresentare il **valore** in una struttura dati che memorizza coppie chiave/valore, come in `Map<K, V>`.|
|`<N>`|Usato per tipi numerici generici, ad esempio, in classi o metodi che lavorano con numeri (`Integer`, `Double`, ecc.). Può essere vincolato a `Number`.|

---
