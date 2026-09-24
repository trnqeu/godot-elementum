extends CharacterBody2D
# Lezione 2: l'eroe ora e' un CharacterBody2D, cioe' un corpo "solido"
# che sbatte contro i muri invece di attraversarli.

@export var velocita: float = 300.0  # quanti pixel al secondo si muove l'eroe


# _physics_process e' come _process, ma viene chiamata a intervalli regolari
# ed e' quella giusta da usare quando ci si muove tra oggetti solidi.
func _physics_process(_delta: float) -> void:
	var direzione := Vector2.ZERO
	direzione.x = Input.get_axis("ui_left", "ui_right")
	direzione.y = Input.get_axis("ui_up", "ui_down")
	direzione = direzione.normalized()

	# "velocity" e' una variabile che ogni CharacterBody2D ha gia': diciamo
	# quanto veloce vogliamo andare e in che direzione...
	velocity = direzione * velocita

	# ...e move_and_slide() muove davvero l'eroe. Se c'e' un muro sulla
	# strada, si ferma (o scivola lungo il muro) e non lo attraversa.
	# Non serve piu' moltiplicare per delta: ci pensa lei.
	move_and_slide()
