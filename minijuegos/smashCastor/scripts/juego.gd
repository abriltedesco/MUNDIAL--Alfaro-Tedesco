extends Node2D

@onready var pozos = [$pozo, $pozo2, $pozo3, $pozo4] 
@onready var timer = $Timer

var puntaje = 0
var vidas = 3
var ultimoTipo = null
var repeticionesTipo = 0

func _ready() -> void:
	randomize()
	timer.timeout.connect(_on_timer_timeout)
	
	for pozo in pozos:
		pozo.golpeado.connect(_on_pozo_golpeado)
		
	actualizarUi()
	timer.wait_time = 0.35
	timer.start() 

func _on_timer_timeout() -> void:
	var pozosDisp = []
	
	for pozo in pozos:
		if !pozo.arriba:
			pozosDisp.append(pozo)
			
	if pozosDisp.is_empty():
		return
		
	var pozoElegido = pozosDisp.pick_random()
	var esHueso = elegirRandom()
	pozoElegido.asomarse(esHueso)
	
	if puntaje < 5 :
		timer.wait_time = randf_range(0.54, 1.0)
	else: 
		timer.wait_time = randf_range(0.35, 0.75)
	timer.start()
	
func elegirRandom() -> bool:
	var esHueso = randf() < 0.35

	if ultimoTipo != null and repeticionesTipo >= 2 and esHueso == ultimoTipo:
		esHueso = !ultimoTipo
	
	if ultimoTipo == esHueso:
		repeticionesTipo += 1
	else:
		ultimoTipo = esHueso
		repeticionesTipo = 1
		
	return esHueso
	
func _on_pozo_golpeado(esHueso: bool) -> void:
	if esHueso:
		puntaje += 1
	else:
		vidas -= 1
		
	actualizarUi()
	
	if puntaje >= 10:
		ganar()
	if vidas <= 0:
		gameOver()

func actualizarUi() -> void:
	#CORRECCION: Al convertir barra_puntaje en una escena por separado, lo más correcto
	# es comunicarnos con un script adjunto en su nodo raiz (barraPuntaje),
	# o a través de señales en un Singleton quizá.
	# Aquí mismo tengo que comentar la linea de vidas porque cambió la escena barra_puntaje
	# y esto no cambió aún, por lo que me da error. 
	$barraPuntaje/puntaje.text = "Puntaje: " + str(puntaje)
	# Si aquí se llamara a $barraPuntaje.set_vidas(vidas) no aparecía ningún error.
	#$barraPuntaje/vidas.text = "Vidas: " + str(vidas)
	
	#HACK PRO TIP
	# Cada escena debe modificarse a sí misma, si otra escena necesitara que esta cambie, se lo pide
	
func ganar() -> void:
	timer.stop()
	
	Progreso.marcarMinijuegoGanado(4)
	if Progreso.datos.nivelDesbloq < 5:
		Progreso.datos.nivelDesbloq = 5
	Progreso.guardarPartida()
	
	get_tree().change_scene_to_file("res://escenas/niveles/nivel_4.tscn")	
	
func gameOver() -> void:
	timer.stop()
	get_tree().reload_current_scene()
