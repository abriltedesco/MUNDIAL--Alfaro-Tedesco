extends Node2D
@onready var ladrilloObj = preload("res://minijuegos/arkanoid/escenas/ladrillo.tscn")
@onready var corazon1 = $vidas/contVidas/corazon1
@onready var corazon2 = $vidas/contVidas/corazon2
@onready var corazon3 = $vidas/contVidas/corazon3
@onready var gameOverCartel = $cartelPerdiste/Label 
@onready var ganasteCartel = $cartelGanaste/Label 

const cols = 8
const filas = 5
const ancho = 128
const alto = 32
const sepX = 4
const sepY = 6
const margenTecho = 85

var cantLadrillos : int

var posInicialPelota: Vector2
var velInicialPelota
var posInicialPaleta: Vector2

func _ready() -> void:
	generar_grilla()
	posInicialPelota = $pelota.position
	posInicialPaleta = $paleta.position	
	gameOverCartel.visible = false
	ganasteCartel.visible = false
	cantLadrillos = cols * filas
	
func restar_ladrillo() -> void:
	cantLadrillos -= 1
	
	if cantLadrillos <= 0:
		ganar()

func ganar() -> void:
		Progreso.marcarMinijuegoGanado(2)
		if Progreso.datos.nivelDesbloq < 3:
			Progreso.datos.nivelDesbloq = 3
		Progreso.guardarPartida()
		
		ganasteCartel.visible = true
		$pelota.activa = false
		
		await get_tree().create_timer(2.0).timeout 
		get_tree().change_scene_to_file("res://escenas/niveles.tscn")


# calculo para q quede lindo y centrado la matriz de ladrillos por ancho y alto
func generar_grilla() -> void:
	var ancho_total = cols * ancho + (cols - 1) * sepX 
	var origen_x = (1152 - ancho_total) / 2.0 + ancho / 2.0 
	var inicio_y = margenTecho + alto / 2.0

	for fila in filas:
		for col in cols:
			var ladrillo = ladrilloObj.instantiate()
			add_child(ladrillo)

			# global_position para ignorar transformación del nodo padre (y q se quede en su pos en juego)
			ladrillo.global_position = Vector2(origen_x + col * (ancho + sepX), inicio_y + fila * (alto  + sepY))

			
func _on_pelota_vida_restada() -> void:
	$pelota.activa = false
	
	$pelota.position = posInicialPelota
	$paleta.position = posInicialPaleta
	
	print("perdiste una de tus vidas") 
	print("vidas restantes: " + str($pelota.vidas))
	$pelota.velocity = Vector2(-$pelota.veloc, $pelota.veloc)

	if $pelota.vidas == 2:
		corazon3.visible = false
	elif $pelota.vidas == 1:
		corazon2.visible = false
		
	await get_tree().create_timer(1.5).timeout # para darle tiempo a player y q no caiga d una
	$pelota.vida_restada = false
	$pelota.activa = true


func _on_pelota_vidas_perdidas() -> void:
	print("perdiste todas tus vidas")
	corazon1.visible = false
	gameOverCartel.visible = true
	
	await get_tree().create_timer(3.5).timeout 
	await get_tree().reload_current_scene()
