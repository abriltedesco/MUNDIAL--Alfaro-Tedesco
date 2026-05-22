extends Node

const rutaGuardado = "user://partida.tres"
var datos: DatosJuego

func _ready() -> void:
	cargarPartida()

func cargarPartida() -> void:
	if ResourceLoader.exists(rutaGuardado):
		datos = load(rutaGuardado)
		print("cargada")
	else:
		# si juega x primera vez, creamos una planilla nueva en blanco
		datos = DatosJuego.new()
		print("planilla nueva creada")

func guardarPartida() -> void:
	ResourceSaver.save(datos, rutaGuardado)
	print("partida guardada")
