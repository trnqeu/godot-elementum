# Lezione 2 — Il tuo primo dungeon

## Obiettivo

Vedere il tuo eroe camminare in una stanza chiusa da muri e capire perché
adesso, invece di attraversarli, ci sbatte contro.

## Concetti nuovi

- **`CharacterBody2D`**: un nodo che si comporta come un corpo solido. Ha una
  variabile `velocity` (la sua velocità) e una funzione `move_and_slide()`
  che lo muove fermandolo davanti agli ostacoli.
- **`StaticBody2D`**: un oggetto solido che non si muove mai (un muro, una
  colonna...).
- **`CollisionShape2D`**: la "forma invisibile" che dice a Godot dove finisce
  un oggetto solido. Senza di lei, un corpo è fantasma.
- **`_physics_process`**: come `_process`, ma pensata per il movimento tra
  oggetti solidi.

## Cosa è cambiato rispetto alla Lezione 1

Il file `player.gd` e la scena `player.tscn` sono stati aggiornati: l'eroe
ora è un `CharacterBody2D` (prima era un semplice `Sprite2D`). Se vuoi
rivedere com'era la versione della Lezione 1, la trovi con il tag
`lezione-01` (ad esempio `git show lezione-01:game/scenes/player/player.gd`).

In più c'è una scena nuova: `game/scenes/rooms/room_01.tscn`, la tua prima stanza.

## Passi hands-on

1. Apri `scenes/rooms/room_01.tscn` (doppio click nel pannello FileSystem).
2. Guarda il pannello **Scene**: la stanza è fatta da un `Pavimento`, quattro
   muri (`MuroSopra`, `MuroSotto`, `MuroSinistra`, `MuroDestra`), una
   `Colonna` in mezzo alla stanza e il `Player`.
3. Apri il nodo `MuroSopra` (clicca la freccina accanto al nome). Dentro ci
   sono **due** cose diverse:
   - `ColorRect` — il rettangolo colorato che **vedi**;
   - `CollisionShape2D` — la forma **invisibile** contro cui si sbatte.

   Sono separate! Puoi avere un muro che si vede ma che si attraversa
   (senza forma), o un muro invisibile ma solido (senza colore).
4. Nel menu **Debug** in alto, attiva **Visible Collision Shapes** (Mostra
   forme di collisione). Ora premi **F6** con `room_01.tscn` aperta:
   vedrai le forme di collisione colorate sopra la stanza.
5. Muovi l'eroe con le frecce e prova a camminare contro i muri e contro la
   colonna: si ferma! Prova anche a spingere in diagonale contro un muro:
   scivola lungo il muro invece di bloccarsi del tutto (è il "slide" di
   `move_and_slide`).
6. Chiudi il gioco e apri `scenes/player/player.tscn`: ora il nodo
   principale è un `CharacterBody2D` con due figli, `Sprite` (quello che
   vedi) e `CollisionShape2D` (la sua forma solida).
7. Apri `player.gd` e leggi i commenti: la novità è che invece di cambiare
   `position` a mano, impostiamo `velocity` e lasciamo a `move_and_slide()`
   il lavoro di muovere l'eroe *rispettando i muri*.

## Checkpoint

Premendo **F6** su `room_01.tscn` si apre una stanza con pavimento scuro,
muri marroni e una colonna a destra. L'eroe parte a sinistra, si muove con le
frecce, e **non riesce ad attraversare** né i muri né la colonna.

Se l'eroe attraversa i muri, controlla che ogni `CollisionShape2D` abbia una
forma (nell'Inspector, il campo **Shape** non deve essere vuoto: un
triangolino giallo accanto al nodo ti avvisa se manca).

## Sfida finale (facoltativa)

1. **Facile**: seleziona il nodo `Colonna`, premi **Ctrl+D** per duplicarlo e
   trascina la copia in un altro punto della stanza. Premi F6: anche la
   nuova colonna è solida!
2. **Più difficile**: costruisci un muro da zero.
   1. Tasto destro sul nodo `Room01` → **Add Child Node** → `StaticBody2D`.
   2. Aggiungi come figlio un `CollisionShape2D`, e nell'Inspector, alla voce
      **Shape**, scegli **New RectangleShape2D**. Trascina le maniglie
      nella vista 2D per dargli le dimensioni che vuoi.
   3. Aggiungi anche un `ColorRect` figlio, con lo stesso spostamento e
      dimensione, così il muro si vede.

## Salva il tuo progresso

```
git add -A
git commit -m "Lezione 2: il mio primo dungeon"
git tag lezione-02
git push origin main --tags
```
