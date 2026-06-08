extends Node2D

func _ready() -> void:
	$kiki.play("ladrar")
	$nani.play("default")
	
	var dialogo = load("res://dialogues/dialogue.dialogue")
	var escenaGlobo = load("res://dialogues/globo_dialogo.tscn").instantiate()
	add_child(escenaGlobo)
	escenaGlobo.start(dialogo, "final", [self])
	
	await DialogueManager.dialogue_ended
	Progreso.guardarPartida() 
	get_tree().quit()
