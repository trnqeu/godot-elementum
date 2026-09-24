# Lezione 0 — Prepariamo il computer

Questa lezione non è di programmazione: serve a installare tutto quello che
serve e a verificare che il progetto funzioni sul tuo computer, prima di
iniziare a scrivere codice nella Lezione 1.

## Obiettivo

Avere Godot installato, il progetto scaricato sul tuo computer, e vederlo
avviarsi senza errori.

## Cosa ti serve

- **Godot Engine 4.x** (versione "Standard", NON quella ".NET"). Scaricalo da
  https://godotengine.org/download — scegli la stessa versione minore (es.
  entrambi 4.3.x oppure entrambi 4.4.x) sia su Windows che su Linux, per
  evitare differenze inutili. Annotate qui la versione scelta: `__4.7.2_________`.
- Un account **GitHub** (gratuito) per entrambi.
- **Su Windows**: installa [GitHub Desktop](https://desktop.github.com/) — è
  un programma con dei bottoni ("Commit", "Push", "Pull") che ti evita di
  usare comandi da terminale.
- **Su Linux**: `git` è già installato o si installa con il gestore pacchetti
  della tua distribuzione (es. `sudo apt install git`).

## Passi hands-on

### Il papà (Linux, da terminale)

1. Crea una repository **privata** su GitHub (es. chiamata `elementum`).
2. Aggiungi tuo figlio come **collaboratore** della repository: Settings →
   Collaborators, inserisci il suo username o la sua email GitHub.
3. Nella cartella del progetto sul tuo computer:
   ```
   git init
   git remote add origin git@github.com:<tuo-utente>/elementum.git
   git add -A
   git commit -m "Scaffolding iniziale del corso"
   git push -u origin main
   ```

### Il figlio (Windows, con GitHub Desktop)

1. Accetta l'invito come collaboratore che ti arriva per email/su GitHub.
2. Apri GitHub Desktop → **File → Clone repository** → scegli `elementum`
   dalla lista → scegli dove salvarla sul tuo computer → **Clone**.
3. Installa Godot 4.x (stessa versione annotata sopra) da
   https://godotengine.org/download.

### Entrambi

1. Apri Godot. Nella schermata iniziale (Project Manager) clicca **Import**.
2. Naviga fino alla cartella `game/` dentro il progetto clonato e seleziona
   il file `project.godot`. Clicca **Import & Edit**.
3. Si apre l'editor di Godot con il progetto **Elementum**. Premi **F5**
   (oppure il triangolo ▶ in alto a destra).

## Checkpoint

Dovrebbe aprirsi una finestra di gioco con sfondo blu scuro e la scritta
"Elementum — il dungeon dei dadi e delle carte". Nessun errore rosso nel
pannello in basso ("Output" o "Debugger").

Se Godot chiede di scegliere una scena principale, seleziona
`scenes/main.tscn` (di solito non serve, è già configurato nel progetto).

## Salva il tuo progresso

Se sei il papà e hai appena fatto il primo push, sei già a posto. Il figlio,
dopo aver clonato, non deve fare nessun commit per questa lezione: si parte
insieme dalla Lezione 1.
