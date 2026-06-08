extends Control


func _ready() -> void:
	pass 
	
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	if !Progreso.datos.vioIntro:
		get_tree().change_scene_to_file("res://escenas/introduccion.tscn")
	elif Progreso.ganoJuegoCompleto():
		Progreso.modoDificil = true
		get_tree().change_scene_to_file("res://escenas/niveles_dificiles.tscn")
	else:
		get_tree().change_scene_to_file("res://escenas/niveles.tscn")
