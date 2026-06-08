extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_pressed() -> void:
	if Progreso.modoDificil:
		get_tree().change_scene_to_file("res://escenas/niveles_dificiles.tscn")
	else:
		get_tree().change_scene_to_file("res://escenas/niveles.tscn")
