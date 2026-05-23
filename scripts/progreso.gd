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
	
func marcarMinijuegoGanado(nivel: int) -> void:
	if !datos.minijuegosGanados.has(nivel):
		datos.minijuegosGanados.append(nivel)
		guardarPartida()
		
func minijuegoGanado(nivel: int) -> bool:
	return datos.minijuegosGanados.has(nivel)
	
func recogerHueso(nivel: int) -> void:
	if datos.huesosRecogidos.has(nivel):
		return
		
	datos.huesosRecogidos.append(nivel)
	datos.huesitosRecolectado += 1
	guardarPartida()
	
func huesoRecogido(nivel: int) -> bool:
	return datos.huesosRecogidos.has(nivel)
	
func ganoJuegoCompleto() -> bool:
	return datos.huesitosRecolectado >= datos.totalHuesitos
