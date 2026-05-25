extends Node2D
@onready var enemigo = $gallo
@onready var hueso = $hueso

func _ready() -> void:
	if Progreso.minijuegoGanado(3):
		enemigo.queue_free()
		
	if Progreso.huesoRecogido(3):
		hueso.queue_free()
