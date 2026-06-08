extends Node2D
var puntaje:int
@onready var temporizador=$Timer
var objetoEscena=preload("res://minijuegos/catcher/objeto.tscn")
var gameOver
var puntosParaGanar
@onready var gameOverCartel = $perdiste
@onready var ganasteCartel = $ganaste

func _ready() -> void:
	#$pedido.visible=true
	
	puntaje=0
	$kikiCatcher.vidas=3
	gameOverCartel.visible = false
	ganasteCartel.visible = false
	$barraPuntaje.set_vidas($kikiCatcher.vidas)
	$barraPuntaje.set_puntaje(0)
	
	if Progreso.modoDificil:
		temporizador.wait_time = 0.5 
		puntosParaGanar = 5
	else:
		temporizador.wait_time = 1.0 
		puntosParaGanar = 10
	
func _on_kiki_catcher_catch_objeto_bueno() -> void:
	puntaje += 1
	$barraPuntaje.set_puntaje(puntaje)
	
	if puntaje >= puntosParaGanar :
		ganasteCartel.visible = true
		temporizador.stop()
		Progreso.marcarMinijuegoGanado(3)
		await get_tree().create_timer(2.0).timeout
		if Progreso.modoDificil:
			if Progreso.ganoTodosDificiles():
				get_tree().change_scene_to_file("res://escenas/final.tscn") 
			else:
				get_tree().change_scene_to_file("res://escenas/niveles_dificiles.tscn")
		else:
			get_tree().change_scene_to_file("res://escenas/niveles/nivel_3.tscn")
	
func _on_kiki_catcher_catch_objeto_malo() -> void:
	$kikiCatcher.vidas -= 1
	$barraPuntaje.set_vidas($kikiCatcher.vidas)
		
	if $kikiCatcher.vidas<=0:
		gameOverCartel.visible = true
		temporizador.stop()

func _on_timer_timeout() -> void:
	var nuevoObjeto = objetoEscena.instantiate()
	var anchoPantalla = get_viewport_rect().size.x
	nuevoObjeto.position = Vector2(randf_range(50, anchoPantalla - 50), -50)
	nuevoObjeto.esBueno = randf() > 0.4
	add_child(nuevoObjeto)

func _on_game_over_reempezar() -> void:
	_ready()
