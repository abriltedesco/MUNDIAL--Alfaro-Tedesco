extends Node2D
var puntaje:int
@onready var temporizador=$Timer
var barraPuntajeVida
var objetoEscena=preload("res://minijuegos/catcher/objeto.tscn")
var gameOver
@onready var corazon1 = $barraPuntaje/vidas/contVidas/corazon1
@onready var corazon2 = $barraPuntaje/vidas/contVidas/corazon2
@onready var corazon3 =  $barraPuntaje/vidas/contVidas/corazon3
@onready var gameOverCartel = $perdiste
@onready var ganasteCartel = $ganaste

func _ready() -> void:
	puntaje=0
	$kikiCatcher.vidas=3
	gameOver=get_node("game_over")
	barraPuntajeVida = get_node("barraPuntaje")
	print("barraPuntaje: ", barraPuntajeVida)
	gameOver.hide()
	$barraPuntaje/puntaje.text = "PUNTAJE: " + str(puntaje)
func _on_kiki_catcher_catch_objeto_bueno() -> void:
	puntaje += 1
	$barraPuntaje/puntaje.text = "PUNTAJE: " + str(puntaje)
	
func _on_kiki_catcher_catch_objeto_malo() -> void:
	$kikiCatcher.vidas -= 1
	
	if $pelota.vidas == 2:
		corazon3.visible = false
	elif $pelota.vidas == 1:
		corazon2.visible = false
		
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
