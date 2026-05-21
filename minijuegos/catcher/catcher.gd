extends Node2D
var puntaje:int
@onready var temporizador=$Timer
var barraPuntajeVida
var objetoEscena=preload("res://minijuegos/catcher/objeto.tscn")
var gameOver

func _ready() -> void:
	puntaje=0
	$kikiCatcher.vidas=3
	gameOver=get_node("game_over")
	barraPuntajeVida = get_node("barraPuntaje")
	print("barraPuntaje: ", barraPuntajeVida)
	gameOver.hide()
	$barraPuntaje/puntaje.text = "PUNTAJE: " + str(puntaje)
	$barraPuntaje/vidas.text = "VIDAS: " + str($kikiCatcher.vidas)
func _on_kiki_catcher_catch_objeto_bueno() -> void:
	puntaje += 1
	$barraPuntaje/puntaje.text = "PUNTAJE: " + str(puntaje)
func _on_kiki_catcher_catch_objeto_malo() -> void:
	$kikiCatcher.vidas -= 1
	$barraPuntaje/vidas.text = "VIDAS: " + str($kikiCatcher.vidas)	
	if $kikiCatcher.vidas<=0:
		get_tree().paused=true
		gameOver.show()
func _on_timer_timeout() -> void:
	var nuevoObjeto=objetoEscena.instantiate()
	var anchoPantalla = get_viewport_rect().size.x
	nuevoObjeto.position = Vector2(randf_range(50, anchoPantalla - 50), -50)
	nuevoObjeto.esBueno = randf() > 0.5
	add_child(nuevoObjeto)


func _on_game_over_reempezar() -> void:
	_ready()
