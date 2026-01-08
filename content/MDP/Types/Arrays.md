Un **array** è una struttura dati che **memorizza più valori dello stesso tipo** in una singola variabile, dunque tale struttura:
- Contiene **elementi dello stesso tipo** (int, double, String, ecc.).
- Ha **una dimensione fissa** che viene definita alla creazione.
- Gli elementi sono **indicizzati**, partendo da **indice 0**.

---
### DICHIARAZIONE E CREAZIONE DI UN ARRAY

La sintassi per dichiarare un array è:

```java
Tipo[] nomeArray;   // Dichiarazione senza inizializzazione
```

Per creare un array (allocare spazio in memoria):

```java
nomeArray = new Tipo[dimensione];   
// Creazione dell'array con una dimensione fissa
```

Esempio di creazione:

```java
int[] numeri = new int[5];  // Array di 5 elementi interi
```

>**N.B.** ⚠ : Dopo la creazione, gli array contengono:
>**0** per gli interi (`int, long, short, byte`).
>**0.0** per i numeri decimali (`double, float`).
>**false** per i booleani.
>**null** per gli oggetti (`String`, `ArrayList`, ecc.).

---
### INIZIALIZZAZIONE DI UN ARRAY

Esistono diversi modi per assegnare valori a un array.
#### Assegnazione manuale

```java
int[] numeri = new int[3];
numeri[0] = 10;
numeri[1] = 20;
numeri[2] = 30;
```

#### Inizializzazione diretta

```java
String[] nomi = {"Tony", "Side", "Pyrex", "Wayne"};
```

---
### ACCESSO AGLI ELEMENTI DELL'ARRAY

Possiamo accedere a un elemento usando il **suo indice**:

```java
public class ArrayExample {
    public static void main(String[] args) {
        int[] numeri = {10, 20, 30};
        System.out.println("Primo numero: " + numeri[0]);  // 10
        System.out.println("Secondo numero: " + numeri[1]); // 20
    }
}
```

---
### LUNGHEZZA DI UN ARRAY (`.length`)

Ogni array ha una proprietà `.length` che indica la sua dimensione.

```java
int[] numeri = {10, 20, 30, 40, 50};
System.out.println("Dimensione dell'array: " + numeri.length);
// Output: Dimensione dell'array: 5
```

---
### SCORRERE UN ARRAY CON IL CICLO `for`

Un array viene spesso elaborato con un **[[for Instruction|ciclo for]]**:

```java
public class ArrayLoop {
    public static void main(String[] args) {
        int[] numeri = {10, 20, 30, 40, 50};
        for (int i = 0; i < numeri.length; i++) {
            System.out.println("Elemento " + i + ": " + numeri[i]);
        }
    }
}
/* Output: 
Elemento 0: 10
Elemento 1: 20
Elemento 2: 30
Elemento 3: 40
Elemento 4: 50 */
```

---
### SCORRERE UN ARRAY CON IL CICLO `for-each`

Il ciclo **[[for Instruction#^3e8bd6|for-each]]** è una versione semplificata per iterare sugli elementi di un array.

```java
public class ForEachExample {
    public static void main(String[] args) {
        int[] numeri = {10, 20, 30, 40, 50};
        for (int numero : numeri) {
            System.out.println("Numero: " + numero);
        }
    }
}
/* Output: 
Elemento: 10
Elemento: 20
Elemento: 30
Elemento: 40
Elemento: 50 */
```

---
### MODIFICA DEGLI ELEMENTI DELL'ARRAY

Gli array sono **mutabili**, quindi possiamo modificare i valori dopo la creazione.

```java
public class ModifyArray {
    public static void main(String[] args) {
        int[] numeri = {10, 20, 30};
        numeri[1] = 50;  // Modifica il secondo elemento
        for (int num : numeri) {
            System.out.println("Numero: " + num);
        }
    }
}
/* Output: 
Elemento: 10
Elemento: 50 
Elemento: 30 */
```

---
### ARRAY MULTIDIMENSIONALI

Un **array multidimensionale** è un array di array. Il più comune è la **matrice** (array bidimensionale).
#### Dichiarazione e Inizializzazione

```java
int[][] matrice = {
    {1, 2, 3}, 
    {4, 5, 6}, 
    {7, 8, 9}
}; // Matrice di interi 3x3
```
#### Accesso agli Elementi

```java
System.out.println(matrice[1][2]);  // Stampa 6 (riga 1, colonna 2)
```

#### Scorrere una Matrice con Due Cicli `for`

```java
public class MatrixExample {
    public static void main(String[] args) {
        int[][] matrice = {
            {1, 2, 3},
            {4, 5, 6},
            {7, 8, 9}
        };
        for (int i = 0; i < matrice.length; i++) {  
	        // Scorre le righe
            for (int j = 0; j < matrice[i].length; j++) {
	            // Scorre le colonne
                System.out.print(matrice[i][j] + " ");
            }
            System.out.println();  // Va a capo dopo ogni riga
        }
    }
}
/* Output:
1 2 3  
4 5 6  
7 8 9 */
```

---
