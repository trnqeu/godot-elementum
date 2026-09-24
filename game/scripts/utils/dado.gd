class_name Dado
extends RefCounted
# Funzioni di utilita' per i tiri di dado, in stile Dungeons & Dragons.
# Non serve creare un oggetto Dado: le funzioni si chiamano direttamente,
# ad esempio: Dado.tira_dado(20) per tirare un d20 (un dado a 20 facce).
#
# Verra' usata a partire dalla Lezione 6, quando il tuo eroe incontrera'
# il primo nemico.


# Tira un dado con il numero di facce indicato e restituisce il risultato.
static func tira_dado(facce: int) -> int:
	return randi_range(1, facce)


# Un attacco va a segno se (tiro + bonus_attacco) e' maggiore o uguale
# alla difesa del bersaglio. Un 20 naturale (il massimo su un d20) e'
# sempre un colpo critico, qualunque sia la difesa del bersaglio!
static func colpisce(bonus_attacco: int, difesa_bersaglio: int) -> Dictionary:
	var tiro := tira_dado(20)
	var critico := tiro == 20
	var successo := critico or (tiro + bonus_attacco) >= difesa_bersaglio
	return {"successo": successo, "critico": critico, "tiro": tiro}
