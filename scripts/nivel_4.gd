extends Node2D


@onready var enemigo = $ardilla
@onready var hueso = $hueso

func _ready() -> void:
	if Progreso.minijuegoGanado(4):
		enemigo.queue_free()
		
	if Progreso.huesoRecogido(4):
		hueso.queue_free()
