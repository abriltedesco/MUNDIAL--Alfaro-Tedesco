extends Node2D

@onready var kiki = $kiki
@onready var nani = $nani

func _ready() -> void:
	kiki.movIntro = true
	nani.movIntro = true
	
	nani.play("sleep")
	kiki.play("walkR")
	
	var tween = create_tween()
	kiki.playSonido("caminando")
	var posNani = Vector2(nani.position.x - 150, nani.position.y)
	tween.tween_property(kiki, "position", posNani, 3.0) 
	await tween.finished
	
	kiki.play("default")
	
	kiki.detenerCaminata()
	var dialogo = load("res://dialogues/dialogue.dialogue")
	var escenaGlobo = load("res://dialogues/globo_dialogo.tscn").instantiate()
	add_child(escenaGlobo)
	escenaGlobo.start(dialogo, "start", [self])
	
	await DialogueManager.dialogue_ended
	
	Progreso.datos.vioIntro = true
	Progreso.guardarPartida() 
	
	get_tree().change_scene_to_file("res://escenas/niveles.tscn")
