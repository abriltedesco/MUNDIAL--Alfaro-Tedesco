extends Node2D
var puntaje:int
@onready var temporizador=$Timer
var objetoEscena=preload("res://minijuegos/catcher/objeto.tscn")
var gameOver
@onready var gameOverCartel = $perdiste
@onready var ganasteCartel = $ganaste

func _ready() -> void:
	puntaje=0
	$kikiCatcher.vidas=3
	gameOverCartel.visible = false
	ganasteCartel.visible = false
	$barraPuntaje.set_vidas($kikiCatcher.vidas)
	$barraPuntaje.set_puntaje(0)
	
func _on_kiki_catcher_catch_objeto_bueno() -> void:
	puntaje += 1
	$barraPuntaje.set_puntaje(puntaje)
	
func _on_kiki_catcher_catch_objeto_malo() -> void:
	$kikiCatcher.vidas -= 1
	
	$barraPuntaje.set_vidas($kikiCatcher.vidas)
		
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
