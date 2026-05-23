extends Node2D
@onready var enemigo = $ardilla
@onready var hueso = $hueso

func _ready() -> void:
	if Progreso.minijuegoGanado(2):
		enemigo.queue_free()
		
	if Progreso.huesoRecogido(2):
		hueso.queue_free()
