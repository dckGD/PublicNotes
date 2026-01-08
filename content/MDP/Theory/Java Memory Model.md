La [[JDK#COMPONENTI DEL JDK|JVM]] (Java Virtual Machine) gestisce l’esecuzione dei programmi Java attraverso un modello di memoria strutturato in aree distinte, ognuna con un ruolo specifico.

---
### HEAP

**Caratteristiche**: 

- Area di memoria più grande, condivisa tra tutti i thread. 
- Gestita dal **Garbage Collector**. 
- Divisa in **Young Generation** (Eden + Survivor spaces) e **Old Generation**.
- Contiene il [[Strings Pool|pool di stringhe]].

**Contenuto**:

- Oggetti creati con `new`.
- Variabili di istanza (campi degli oggetti).
- Array.

---
### STACK

**Caratteristiche**:

- Ogni thread ha il proprio stack.
- Memoria veloce ma limitata.
- I frame vengono creati quando un metodo viene chiamato e rimossi alla sua uscita.

**Contenuto**:

- Variabili locali (primitive e riferimenti ad oggetti nell’Heap).
- Parametri dei metodi.
- Indirizzi di ritorno.

---
### METASPACE

**Caratteristiche**:

- Ha sostituito il vecchio **PermGen** (presente da Java 8 in poi).
- Risiede nella **memoria nativa**.
- Dimensione dinamica: cresce a seconda delle necessità, riducendo gli errori `OutOfMemoryError`.

**Contenuto**:

- Metadati delle **classi caricate** (nomi, metodi, campi, bytecode).
- Costanti e pool dei metodi.
- Dati usati dai **Class Loader**.   

---
### PROGRAM COUNTER

**Caratteristiche**:

- Ogni thread ha il proprio registro PC.
- Contiene l’indirizzo della prossima istruzione da eseguire.

**Contenuto**:

- Indice/posizione dell’istruzione corrente della JVM per quel thread.

---
### NATIVE METHOD STACK

**Caratteristiche**:

- Separato dallo stack Java.
- Usato per l’esecuzione di metodi scritti in linguaggi nativi (C, C++).
- Ogni thread ha il proprio Native Method Stack.

**Contenuto**:

- Variabili locali e strutture di supporto per i metodi nativi invocati tramite **JNI (Java Native Interface)**.

---
### SCHEMA

```r
+---------------------------+
|           Heap            |          
|   Location: Native Memory |
+---------------------------+
|        Metaspace          |
|   Location: Native Memory |
+---------------------------+
|           Stack           |
|   Location: Thread Memory |
+---------------------------+
|   Native Method Stack     |
|   Location: Thread Memory |
+---------------------------+
|       PC Register         |
|   Location: Thread Memory |
+---------------------------+
|        Code Cache         |
|   Location: Native Memory |
+---------------------------+

```

---
### ESEMPIO DI GESTIONE

```java
class Persona {
	
	static int contatore = 0;  
	// Memorizzato nel METASPACE (perché è statico)
	
    String nome;  
    // Memorizzato nell'HEAP (parte dell'oggetto)
    
    public Persona(String nome) {
        this.nome = nome;  
        // La variabile nome è salvata nell'HEAP
        contatore++;  
        // La variabile statica rimane nel METASPACE
    }
    
    public void mostraNome() {
        System.out.println("Nome: " + nome); 
        // La variabile "nome" è recuperata dall'HEAP
    }
    
    // Metodo statico (memorizzato nel METASPACE)
    public static void mostraContatore() {
        System.out.println("Numero di persone create: " + contatore);
    }
}

public class StackHeapExample {
    public static void main(String[] args) {
    
        int x = 10;  
        // Memorizzato nello STACK (variabile locale)  
        
        Persona p1 = new Persona("Travis");  
        // "p1" è nello STACK, ma il suo oggetto (Travis) è nell'HEAP
        
        Persona p2 = new Persona("Kanye");    
        // "p2" è nello STACK, ma il suo oggetto (Kanye) è nell'HEAP
        
        p1.mostraNome();  
        // Recupera "Travis" dall'HEAP
        
        p2.mostraNome();  
        // Recupera "Kanye" dall'HEAP
		
        Persona.mostraContatore();
		/* Chiamata a un metodo statico 
		   (non dipende da un'istanza singola, eseguito dal Metaspace) */
    }
}
```

In generale, la memoria in Java è progettata per gestire oggetti, variabili locali e metadati in modo separato e ottimizzato, con l'aiuto del Garbage Collector per evitare perdite di memoria.

---