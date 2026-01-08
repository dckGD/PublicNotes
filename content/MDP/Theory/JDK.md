Il **JDK (Java Development Kit)** è un kit di sviluppo software utilizzato per creare applicazioni e [[Applet]] in Java. È fornito da **Oracle Corporation** e include tutto il necessario per **scrivere, compilare, eseguire e fare il debug** di programmi Java.

---
### COMPONENTI DEL JDK

Il JDK è composto dai seguenti elementi principali:

**JRE (Java Runtime Environment)**: consente di eseguire programmi Java, ma non include strumenti per lo sviluppo. Comprende la **JVM (Java Virtual Machine)** e le librerie di base.

**JVM (Java Virtual Machine)**: è responsabile dell'esecuzione dei programmi Java, traducendo il **[[Bytecode]]** in istruzioni comprensibili dalla macchina su cui il programma è eseguito. (gestisce la memoria)

**Compilatore Java (javac)**: Il **compilatore Java** traduce il codice sorgente (.java) in **[[Bytecode]]** (.class), che può essere eseguito dalla JVM.

**Strumenti di sviluppo**: Include debugger (jdb), profiler, strumenti per la gestione dei pacchetti (jar) e altre utility.

---
### COME INSTALLARE IL JDK

1. Scarica il JDK dal sito ufficiale di **Oracle** o **OpenJDK**.
2. Installa il JDK seguendo le istruzioni per il tuo sistema operativo.
3. Configura la variabile d'ambiente `JAVA_HOME` e aggiungi il percorso del JDK al `PATH`.
4. Verifica l'installazione con i comandi:

```sh
java -version
```

```sh
javac -version
```

---
### WRITE ONCE, RUN EVERYWHERE (WORA)

Grazie alla **JVM (Java Virtual Machine)**, il codice Java può essere eseguito su qualsiasi dispositivo che abbia una JVM compatibile, senza bisogno di essere riscritto o ricompilato.

- Il codice Java viene scritto e compilato in **[[Bytecode]]** (.class).
- Il bytecode non è dipendente dal sistema operativo o dall'hardware.
- La **JVM interpreta ed esegue** il bytecode su qualsiasi dispositivo compatibile con Java.

```powershell
1️ Codice sorgente Java  (.java)

        ⬇ [Compilazione con javac]  

2️ Bytecode Java  (.class)  

		⬇ [Interpretazione/Esecuzione con JVM]  

3️ Codice Macchina (Machine Code) [adatto all'hardware specifico]
```

---