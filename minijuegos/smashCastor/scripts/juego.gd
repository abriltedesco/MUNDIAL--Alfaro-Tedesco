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
	$barraPuntaje/puntaje.text = "Puntaje: " + str(puntaje)
	$barraPuntaje/vidas.text = "Vidas: " + str(vidas)
	
func ganar() -> void:
	timer.stop()
	
	Progreso.datos.huesitosRecolectado+=1
	if Progreso.datos.nivelDesbloq < 5:
		Progreso.datos.nivelDesbloq = 5
	Progreso.guardarPartida()
	
	
	
func gameOver() -> void:
	timer.stop()
	get_tree().reload_current_scene()
