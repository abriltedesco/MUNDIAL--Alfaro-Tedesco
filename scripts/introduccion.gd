extends Node2D


func _ready() -> void:
	$kiki.movIntro = true
	$nani.play("sleep")
	$kiki.play("walkR")
	
	var tween = create_tween() # motor de animación por código
	var posNani = Vector2($nani.position.x - 150, $nani.position.y)
	tween.tween_property($kiki, "position", posNani, 3.0) # se mueve hacia donde está nani
	await tween.finished
	
	$kiki.play("default")
	
	DialogueManager.show_example_dialogue_balloon(load("res://dialogues/dialogue.dialogue"), "start", [self])
