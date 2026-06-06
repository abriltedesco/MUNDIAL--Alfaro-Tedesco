extends Node2D
@onready var enemigo = $ardilla
@onready var hueso = $hueso
@onready var cantidadHuesos=$huesosActualizacion/cantidad

func _ready() -> void:
	cantidadHuesos.text = str(Progreso.datos.huesitosRecolectado)
	if Progreso.minijuegoGanado(4):
		enemigo.queue_free()
		
	if Progreso.huesoRecogido(4):
		hueso.queue_free()
		cantidadHuesos.text=str(int(cantidadHuesos.text) + 1)
	else:
		hueso.recogido.connect(_on_hueso_recogido)
func _on_hueso_recogido() -> void:
	cantidadHuesos.text=str(int(cantidadHuesos.text) + 1)
