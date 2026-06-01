extends Node2D
@onready var enemigo = $dragon
@onready var hueso = $hueso

func _ready() -> void:
	if Progreso.minijuegoGanado(2):
		enemigo.queue_free()
		
	if Progreso.huesoRecogido(2):
		hueso.queue_free()
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://escenas/niveles.tscn")
