extends CanvasLayer

func _ready() -> void:
	visible = true

func _on_reintentar_button_down() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://minijuegos/catcher/catcher.tscn")
