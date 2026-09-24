# Lezione 1 — Il tuo eroe si muove!

## Obiettivo

Capire come funziona il movimento del tuo eroe leggendo il codice già
presente nel progetto, provarlo con la tastiera, e personalizzarlo.

## Concetti nuovi

- **Nodi e scene**: in Godot ogni "cosa" nel gioco (un personaggio, un
  nemico, un muro...) è un **nodo**, e un gruppo di nodi organizzati insieme
  è una **scena**.
- **Script**: un file di codice (GDScript, estensione `.gd`) che si può
  "attaccare" a un nodo per dargli un comportamento.
- **`_process(delta)`**: una funzione speciale che Godot chiama automaticamente
  ad ogni fotogramma (di solito 60 volte al secondo). `delta` è il tempo
  passato dall'ultimo fotogramma.
- **`@export`**: rende una variabile modificabile dal pannello Inspector di
  Godot, senza dover toccare il codice.

## Passi hands-on

1. Apri il progetto **Elementum** in Godot (se non l'hai già aperto dalla
   Lezione 0).
2. Nel pannello **FileSystem** (di solito in basso a sinistra), apri la
   cartella `scenes/player/` e fai doppio click su `player.tscn`.
3. Guarda il pannello **Scene** (in alto a sinistra): c'è un solo nodo,
   chiamato `Player`, di tipo `Sprite2D` (uno sprite = un'immagine 2D). Ha
   un'iconcina che indica che ha uno script attaccato.
4. Clicca sull'iconcina dello script accanto al nodo `Player` (oppure fai
   doppio click su `player.gd` nel FileSystem): si apre l'editor di codice
   con `player.gd`. Leggi i commenti (le righe che iniziano con `#`): spiegano
   cosa fa ogni riga.
5. Con `player.tscn` ancora aperto, premi **F6** (non F5!): F6 esegue solo la
   scena che hai aperto in questo momento, utile per testare un pezzo di
   gioco alla volta senza passare dal menu principale.
6. Muovi l'eroe con le **frecce direzionali** della tastiera.
7. Chiudi la finestra di gioco, torna su Godot, clicca sul nodo `Player` nel
   pannello Scene: nell'**Inspector** (a destra) vedrai la proprietà
   **Velocita**. Cambiala (es. da 300 a 600) e premi di nuovo F6: l'eroe si
   muove più veloce, senza aver toccato una riga di codice!

## Checkpoint

Premendo F6 su `player.tscn` si apre una finestra con sfondo scuro e uno
sprite giallo/blu al centro, che si muove con le frecce direzionali. Muovendo
in diagonale non va più veloce che muovendo dritto (merito di `normalized()`).

## Sfida finale (facoltativa)

Per ora l'eroe può uscire dallo schermo camminando. Prova ad aggiungere,
alla fine della funzione `_process`, queste righe per tenerlo dentro i bordi
della finestra (1152x648 pixel):

```gdscript
position.x = clamp(position.x, 0, 1152)
position.y = clamp(position.y, 0, 648)
```

`clamp(valore, minimo, massimo)` "blocca" un numero dentro un intervallo: se
`position.x` prova ad andare sotto 0 o sopra 1152, viene riportato al limite
più vicino.

## Salva il tuo progresso

```
git add -A
git commit -m "Lezione 1: il mio eroe si muove"
git tag lezione-01
git push origin main --tags
```
