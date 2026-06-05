extends Node2D
@onready var enemigo = $snakePersonaje
@onready var hueso = $hueso
@onready var cantidadHuesos=$huesosActualizacion/cantidad

func _ready() -> void:
	pass
	if Progreso.minijuegoGanado(1):
		enemigo.queue_free()
		
	if Progreso.huesoRecogido(1):
		hueso.queue_free()
		cantidadHuesos.text=str(int(cantidadHuesos.text) + 1)
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://escenas/niveles.tscn")
