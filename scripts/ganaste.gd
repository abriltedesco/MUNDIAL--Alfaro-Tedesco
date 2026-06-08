extends Node2D

@onready var kiki = $kiki
@onready var nani = $nani

func _ready() -> void:
	$sonidoParque.play()
	kiki.movIntro = true
	nani.movIntro =true
	$sonidoGanaste.play()
	
	nani.play("walkR")
	kiki.play("walkR")
	kiki.playSonido("caminando")
	nani.playSonido("caminando")
	nani.get_node("AnimatedSprite2D").flip_h = true 
	
	var tween = create_tween()
	
	# ambas animaciones ocurren a la vez
	tween.set_parallel(true)
	tween.tween_property(kiki, "position:x", 500, 3.0) 
	tween.tween_property(nani, "position:x", 650, 3.0)
	tween.set_parallel(false) 
	await tween.finished
	kiki.detenerCaminata()
	nani.detenerCaminata()
	
	kiki.play("ladrar")
	kiki.playSonido("ladrido")
	nani.play("default")
	nani.playSonido("feliz")
	
	var dialogo = load("res://dialogues/dialogue.dialogue")

	var escenaGlobo = load("res://dialogues/globo_dialogo.tscn").instantiate()
	add_child(escenaGlobo)
	escenaGlobo.start(dialogo, "ganaste", [self])
	
	await DialogueManager.dialogue_ended
	
	Progreso.datos.gano = true
	Progreso.guardarPartida() 
	
	get_tree().change_scene_to_file("res://escenas/niveles_dificiles.tscn")
