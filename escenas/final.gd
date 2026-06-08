extends Node2D
@onready var kiki = $kiki
@onready var nani = $nani

func _ready() -> void:
	$sonidoParque.play()
	kiki.play("ladrar")
	nani.play("default")
	
	$sonidoGanaste.play()
	var dialogo = load("res://dialogues/dialogue.dialogue")
	var escenaGlobo = load("res://dialogues/globo_dialogo.tscn").instantiate()
	add_child(escenaGlobo)
	escenaGlobo.start(dialogo, "final", [self])
	
	await DialogueManager.dialogue_ended
	Progreso.guardarPartida() 
	get_tree().quit()
