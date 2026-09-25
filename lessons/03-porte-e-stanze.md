# Lezione 3 — Porte e stanze

## Obiettivo

Costruire con le tue mani una **porta** che, quando l'eroe ci cammina dentro,
lo porta in un'altra stanza, e scrivere il tuo primo script da zero.

## Concetti nuovi

- **`Area2D`**: una zona **invisibile e non solida**. Non blocca nessuno, ma
  si accorge quando qualcosa ci entra o ci esce. Perfetta per porte,
  trappole, monete da raccogliere...
- **Segnali**: un modo che hanno i nodi per "gridare" che è successo
  qualcosa. L'`Area2D` grida `body_entered` ("è entrato un corpo!") e tu
  puoi collegare quel grido a una tua funzione, che partirà da sola.
- **`if`**: fa eseguire delle righe di codice **solo se** una condizione è
  vera. È il modo in cui il tuo programma prende decisioni.
- **Cambiare scena**: con `get_tree().change_scene_to_file(...)` il gioco
  butta via la stanza in cui sei e carica quella nuova.

## Cosa trovi di nuovo nel progetto

Una seconda stanza già pronta: `game/scenes/rooms/room_02.tscn`. È uguale
alla prima, ma con il pavimento verde e la colonna spostata. Non ha ancora
porte: quelle le costruisci tu!

Da questa lezione in poi, **il codice lo scrivi tu**. Nelle lezioni 1 e 2 lo
hai letto; adesso tocca a te.

## Passi hands-on

### Parte A — La scena della porta

1. In alto, menu **Scene → New Scene**. Nel pannello Scene scegli
   **Other Node**, cerca `Area2D` e premi **Create**.
2. Fai doppio click sul nome del nodo e rinominalo `Porta`.
3. Tasto destro su `Porta` → **Add Child Node** → `CollisionShape2D`.
   Nell'Inspector, alla voce **Shape**, scegli **New RectangleShape2D**.
   Poi clicca sulla forma appena creata per aprirla e scrivi
   **Size**: `x = 40`, `y = 96`.
4. Tasto destro su `Porta` → **Add Child Node** → `ColorRect` (così la porta
   si vede). Nell'Inspector apri **Layout → Transform** e scrivi:
   - **Position**: `x = -20`, `y = -48`
   - **Size**: `x = 40`, `y = 96`

   Poi cambia **Color** in un giallo/oro: è la tua porta magica.

   > Perché -20 e -48? Il `ColorRect` parte dal suo angolo in alto a
   > sinistra, mentre la forma di collisione è centrata. Spostandolo di metà
   > larghezza e metà altezza, i due combaciano. È lo stesso trucco usato
   > nei muri della Lezione 2.
5. Salva la scena con **Ctrl+S** in `scenes/rooms/porta.tscn`.

### Parte B — Il tuo primo script

6. Tasto destro su `Porta` → **Attach Script**. Controlla che il percorso sia
   `res://scenes/rooms/porta.gd` e premi **Create**.
7. Si apre l'editor di codice. Cancella tutto quello che c'è e scrivi
   (a mano, non copiare e incollare: così le dita imparano!):

   ```gdscript
   extends Area2D
   # Lezione 3: una porta e' un'Area2D, cioe' una zona che NON blocca
   # nessuno ma si accorge quando qualcuno ci entra.

   # La stanza in cui ci porta questa porta. Si sceglie dall'Inspector.
   @export_file("*.tscn") var stanza_destinazione: String
   ```

   `@export` lo conosci già dalla Lezione 1. `@export_file("*.tscn")` è suo
   cugino: nell'Inspector ti mostrerà un pulsante a forma di cartella per
   scegliere un file di scena, invece di doverne scrivere il percorso.

   Per l'indentazione (lo spazio all'inizio delle righe) usa sempre il tasto
   **Tab**, mai gli spazi.
8. Salva con **Ctrl+S**.

### Parte C — Collegare il segnale

9. Torna alla vista 2D (in alto, **2D**) e seleziona il nodo `Porta`.
10. Accanto all'**Inspector**, a destra, apri la scheda **Signals**
    (Segnali). Vedi la lista dei segnali che un'`Area2D` sa "gridare".
11. Fai doppio click su **body_entered(body: Node2D)**. Nella finestra che
    si apre, seleziona il nodo `Porta` come destinatario e premi
    **Connect**.
12. Godot ti riporta nello script e ha aggiunto da solo una funzione nuova,
    con una piccola icona verde a sinistra (vuol dire: "questa funzione è
    collegata a un segnale"):

    ```gdscript
    func _on_body_entered(body: Node2D) -> void:
    	pass # Replace with function body.
    ```

    `body` è il corpo che è appena entrato nella porta. Per ora sostituisci
    la riga `pass ...` con:

    ```gdscript
    	print(body.name)
    ```

    `print` scrive un messaggio nel pannello **Output** in basso. È il modo
    più semplice per "spiare" cosa succede nel tuo gioco.

### Parte D — Una spiata istruttiva

13. Apri `room_01.tscn`. Trascina `porta.tscn` dal pannello FileSystem
    dentro la vista 2D della stanza. Seleziona la nuova `Porta` e
    nell'Inspector scrivi **Position**: `x = 1100`, `y = 324` (appoggiata
    al muro di destra).
14. Premi **F6** e cammina con l'eroe fino alla porta (la colonna è in mezzo:
    girale intorno!). Poi chiudi il gioco e guarda il pannello **Output**.
    Vedrai qualcosa del genere:

    ```
    MuroDestra
    Player
    ```

    Sorpresa: **anche il muro** è "entrato" nella porta! È un corpo solido
    anche lui, e la porta lo tocca fin dall'inizio. Se la porta cambiasse
    stanza con qualunque corpo, ti teletrasporteresti appena parte il
    gioco. Ci serve un modo per dire "solo se è l'eroe"...

### Parte E — La decisione: `if`

15. Torna in `porta.gd` e sostituisci la riga `print(body.name)` in modo
    che la funzione diventi così:

    ```gdscript
    # Godot chiama questa funzione quando un corpo entra nella porta,
    # perche' l'abbiamo collegata al segnale "body_entered".
    func _on_body_entered(body: Node2D) -> void:
    	# Anche i muri sono "corpi"! Controlliamo che sia proprio l'eroe.
    	if body.name == "Player":
    		# call_deferred = "fallo appena hai finito coi calcoli delle collisioni".
    		get_tree().change_scene_to_file.call_deferred(stanza_destinazione)
    ```

    Attenzione a tre cose:
    - `==` (due uguali) **confronta** due cose: "il nome è uguale a
      Player?". Un solo `=` invece **assegna** un valore, come in
      `velocity = ...`. Confonderli è l'errore più comune in assoluto!
    - La riga dopo l'`if` ha **un Tab in più**: è così che Godot capisce
      quali righe fanno parte dell'`if`.
    - Il `:` alla fine della riga dell'`if` è obbligatorio.

    > Perché `call_deferred`? La porta si accorge dell'eroe **mentre** Godot
    > sta ancora calcolando le collisioni. Cancellare la stanza proprio in
    > quel momento è come togliere la sedia a qualcuno mentre si siede:
    > Godot si arrabbia e scrive un errore rosso nell'Output. Con
    > `call_deferred` gli diciamo "cambia stanza appena hai finito".
16. Salva, torna in `room_01.tscn`, seleziona la `Porta` e nell'Inspector
    trovi il campo **Stanza Destinazione**. Clicca l'icona della cartella e
    scegli `scenes/rooms/room_02.tscn`.

### Parte F — La porta per tornare indietro

17. Apri `room_02.tscn`, trascina dentro un'altra `porta.tscn` e mettila a
    **Position** `x = 52`, `y = 324` (sul muro di sinistra). Come
    **Stanza Destinazione** scegli `scenes/rooms/room_01.tscn`.

    Hai appena **riusato** una scena: una sola `porta.tscn`, due porte
    diverse nel gioco, ognuna con la sua destinazione scelta
    dall'Inspector.
18. Ultimo tocco: nel pannello FileSystem fai tasto destro su
    `room_01.tscn` → **Set as Main Scene**. Da adesso **F5** fa partire
    il gioco vero direttamente dalla prima stanza.

## Checkpoint

Premi **F5**: parte la stanza blu. Gira intorno alla colonna e cammina
nella porta gialla a destra: appari nella stanza **verde**. Cammina nella
porta gialla a sinistra: torni nella stanza blu. Il pannello Output non
mostra errori rossi.

Se non succede, controlla:
- **Non succede niente quando tocchi la porta**: nella scheda **Signals**
  della `Porta` sotto `body_entered` deve esserci il collegamento a
  `_on_body_entered`, e nello script deve esserci l'iconcina verde accanto
  alla funzione. Controlla anche che la `CollisionShape2D` della porta abbia
  una **Shape**.
- **Errore rosso `Resource file not found: res://`** quando tocchi una
  porta: hai dimenticato di scegliere la **Stanza Destinazione**
  nell'Inspector di quella porta.

## Sfida finale (facoltativa)

1. **Facile**: nella stanza 1 l'eroe riappare sempre a sinistra, anche
   quando torna dalla stanza 2. Sposta il nodo `Player` di `room_01.tscn`
   vicino alla porta di destra, così sembra davvero che torni da lì. Occhio
   a non metterlo **dentro** la porta: cosa succederebbe? Prova e scoprilo!
2. **Più difficile**: crea una terza stanza. Fai tasto destro su
   `room_02.tscn` nel FileSystem → **Duplicate**, chiamala `room_03.tscn`,
   cambia il colore del pavimento, e aggiungi le porte per andare dalla
   stanza 2 alla 3 e ritorno. Non serve nessuna riga di codice nuova!

## Salva il tuo progresso

```
git add -A
git commit -m "Lezione 3: porte e stanze"
git tag lezione-03
git push origin main --tags
```
