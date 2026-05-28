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
	gameOverCartel.visible = false
	ganasteCartel.visible = false
	corazon1.visible = true
	corazon2.visible = true
	corazon3.visible = true
	$barraPuntaje/puntaje.text = "PUNTAJE: " + str(puntaje)
	
	gameOver=get_node("game_over")
	barraPuntajeVida = get_node("barraPuntaje")
	print("barraPuntaje: ", barraPuntajeVida)
	#gameOver.hide()
	
func _on_kiki_catcher_catch_objeto_bueno() -> void:
	puntaje += 1
	$barraPuntaje/puntaje.text = "PUNTAJE: " + str(puntaje)
	if puntaje==10:
		$ganaste.show()
	
func _on_kiki_catcher_catch_objeto_malo() -> void:
	$kikiCatcher.vidas -= 1
	
	if $kikiCatcher.vidas == 2:
		corazon3.visible = false
	elif $kikiCatcher.vidas == 1:
		corazon2.visible = false
		
	if $kikiCatcher.vidas<=0:
		gameOverCartel.visible = true
		temporizador.stop()
		
func _on_timer_timeout() -> void:
	var nuevoObjeto=objetoEscena.instantiate()
	var anchoPantalla = get_viewport_rect().size.x
	nuevoObjeto.position = Vector2(randf_range(50, anchoPantalla - 50), -50)
	nuevoObjeto.esBueno = randf() > 0.5
	add_child(nuevoObjeto)


func _on_game_over_reempezar() -> void:
	_ready()
