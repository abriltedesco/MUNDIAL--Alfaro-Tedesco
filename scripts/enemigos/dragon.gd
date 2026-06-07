extends StaticBody2D 

var hablando = false

func _on_zona_dialogo_body_entered(body: Node2D) -> void:
	if body.name == "nani" and not hablando and not Progreso.minijuegoGanado(2):
		hablando = true
		body.movIntro = true
		body.play("default")
		
		var recurso = load("res://dialogues/dialogue.dialogue")
		var escenaGlobo = load("res://dialogues/globo_dialogo.tscn").instantiate()
		get_tree().current_scene.add_child(escenaGlobo)
		escenaGlobo.start(recurso, "charla_dragon", [self])

func irAlMinijuego() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW) 
	get_tree().change_scene_to_file("res://minijuegos/arkanoid/escenas/nivel_1.tscn")
