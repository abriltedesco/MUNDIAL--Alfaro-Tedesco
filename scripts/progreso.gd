extends Node

var modoDificil = false
const rutaGuardado = "user://partida.tres"
var datos: DatosJuego

func _ready() -> void:
	rutaGuardado.erase(0,0)
	cargarPartida()

func cargarPartida() -> void:
	if ResourceLoader.exists(rutaGuardado):
		datos = load(rutaGuardado)
		if datos.totalHuesitos != 4:
			datos.totalHuesitos = 4
			guardarPartida()
		print("cargada")
	else:
		# si juega x primera vez, creamos una planilla nueva en blanco
		datos = DatosJuego.new()
		print("planilla nueva creada")

func guardarPartida() -> void:
	ResourceSaver.save(datos, rutaGuardado)
	print("partida guardada")
	
func marcarMinijuegoGanado(nivel: int) -> void:
	if modoDificil:
		if !datos.ganadosDificil.has(nivel):
			datos.ganadosDificil.append(nivel)
	else:
		if !datos.minijuegosGanados.has(nivel):
			datos.minijuegosGanados.append(nivel)
			
	guardarPartida()
		
func minijuegoGanado(nivel: int) -> bool:
	if modoDificil:
		return datos.ganadosDificil.has(nivel) 
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
	
func ganoTodosDificiles() -> bool:
	var lista = datos.get("ganadosDificil")
	if lista != null and lista.size() >= 4:
		return true
	else:
		return false
