extends Node2D

@onready var pozos = [$pozo, $pozo2, $pozo3, $pozo4] 
@onready var timer = $Timer
@onready var gameOverCartel = $perdiste
@onready var ganasteCartel = $ganaste

var puntosParaGanar = 15
var puntaje = 0
var vidas = 3
var ultimoTipo = null
var repeticionesTipo = 0

func _ready() -> void:
	gameOverCartel.visible = false
	ganasteCartel.visible = false
	randomize()
	timer.timeout.connect(_on_timer_timeout)
	
	for pozo in pozos:
		pozo.golpeado.connect(_on_pozo_golpeado)
		
	actualizarUi()
	
	if Progreso.modoDificil:
		$TiempoLimite.wait_time = 90.0
		$TiempoLimite.start()
		
	timer.wait_time = 0.35
	timer.start() 
	
func _process(delta: float) -> void:
	if Progreso.modoDificil and !$TiempoLimite.is_stopped():
		$barraPuntaje.mostrarTiempo()
		$barraPuntaje/LabelTiempo.text = "Tiempo: " + str(int($TiempoLimite.time_left))

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
	
	if Progreso.modoDificil:
		if puntaje < 5:
			timer.wait_time = randf_range(0.3, 0.6)
		else: 
			timer.wait_time = randf_range(0.2, 0.4) 
	else:
		if puntaje < 5:
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
		$huesoRecolectado.play()
		puntaje += 1
	else:
		$ardilla.play()
		vidas -= 1
		
	actualizarUi()
			
	if Progreso.modoDificil:
		puntosParaGanar = 10
	
	if puntaje >= puntosParaGanar:
		ganar()
	if vidas <= 0:
		gameOver()

func actualizarUi() -> void:
	$barraPuntaje.set_puntaje(puntaje)
	$barraPuntaje.set_vidas(vidas)
	
func ganar() -> void:
	$TiempoLimite.stop()
	ganasteCartel.playSonido()
	ganasteCartel.visible = true
	timer.stop()
	
	Progreso.marcarMinijuegoGanado(4)
	
	if Progreso.modoDificil:
		if Progreso.ganoTodosDificiles():
			get_tree().change_scene_to_file("res://escenas/final.tscn")
		else:
			get_tree().change_scene_to_file("res://escenas/niveles_dificiles.tscn")
	else:
		get_tree().change_scene_to_file("res://escenas/niveles/nivel_4.tscn")
	
func gameOver() -> void:
	gameOverCartel.visible = true
	timer.stop()

func _on_tiempo_limite_timeout() -> void:
	gameOver()
