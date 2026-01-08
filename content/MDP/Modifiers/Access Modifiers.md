In Java, i **modificatori di accesso** definiscono la **visibilità** e il **contesto di accesso** a variabili, metodi e classi:

- **default** (nessun modificatore): accessibile solo alle classi nello stesso package.
- **private**: accessibile solo all'interno della classe.
- **protected**: accessibile alle sottoclassi e alle classi nello stesso package.
- **public**: accessibile ovunque nel programma.

| **Modificatore** | **Classe stessa** | **Sottoclassi (stesso package)** | **Sottoclassi (altro package)** | **Classi esterne (fuori dal package e non sottoclassi)** |
| ---------------- | ----------------- | -------------------------------- | ------------------------------- | -------------------------------------------------------- |
| **private**      | ✅ Sì              | ❌ No                             | ❌ No                            | ❌ No                                                     |
| **default**      | ✅ Sì              | ✅ Sì                             | ❌ No                            | ❌ No                                                     |
| **protected**    | ✅ Sì              | ✅ Sì                             | ✅ Sì                            | ❌ No                                                     |
| **public**       | ✅ Sì              | ✅ Sì                             | ✅ Sì                            | ✅ Sì                                                     |
>In Java, **le [[Classes#CLASSE INTERNA|classi interne]] non statiche** hanno accesso diretto a **tutti** i membri della classe esterna, **anche se privati**.

---