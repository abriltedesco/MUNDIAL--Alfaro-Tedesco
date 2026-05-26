extends CanvasLayer

@export var escenaAreintentar = ""

func _ready() -> void:
	visible = false

func _on_reintentar_button_down() -> void:
	get_tree().paused = false
	if escenaAreintentar != "":
		get_tree().change_scene_to_file(escenaAreintentar)
	else:
		get_tree().reload_current_scene()

func _on_salir_button_down() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://escenas/niveles.tscn")
