Java ha tre modi di scrivere commenti:

I commenti che iniziano con `//` durano fino alla fine della linea:

```java
System.out.println("Hello World!");  // Stampa a video
```

---

I commenti che possono prendere più di una linea sono racchiusi tra `/*` e `*/`:

```java
System.out.println("Hello World!");  /* Invoca il metodo println 
                                       del campo statico out
                                       della classe System */
```

---

Il terzo tipo di commenti possono essere usati per generare la documentazione in modo automatico. Questi iniziano con `/**` e terminano con `*/`. Generalmente sono usati solamente per documentare le definizioni di classi, interfacce, metodi e campi:

```java
/** Metodo speciale invocato per iniziare l'esecuzione di un programma.
 * In questo caso stampa a video "Hello World!".
 * @param args  gli argomenti letti dalla linea di comando */
public static void main(String[] args) {
    System.out.println("Hello World!");
}
```

---
