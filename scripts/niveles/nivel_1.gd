extends Node2D
@onready var enemigo = $snakePersonaje
@onready var hueso = $hueso

func _ready() -> void:
	if Progreso.minijuegoGanado(1):
		enemigo.queue_free()
		
	if Progreso.huesoRecogido(1):
		hueso.queue_free()
