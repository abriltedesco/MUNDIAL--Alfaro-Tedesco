extends Node2D
@export var serpienteEscena:PackedScene
var puntaje:int
var juegoEmpezado:bool=false
var cantCeldasX:int=22
var cantCeldasY:int=12
var tamanioCelda:int=50 #en pixeles

#serpiente
var datosViejos:Array
var datos:Array
var serpiente: Array
var posInicio=Vector2(9,2)
var arriba=Vector2(0,-1)
var abajo=Vector2(0,1)
var derecha=Vector2(1,0)
var izquierda=Vector2(-1,0)
var direccion:Vector2
var puedeMoverse:bool=true
var vidas:int = 3
var termino:bool = false
var cabeza=StyleBoxTexture.new()
var cola=StyleBoxTexture.new()
var cuerpo=StyleBoxTexture.new()

var comidaPos:Vector2
var regenerarComida: bool=true

@onready var corazon1 = $barraPuntaje/vidas/contVidas/corazon1
@onready var corazon2 = $barraPuntaje/vidas/contVidas/corazon2
@onready var corazon3 =  $barraPuntaje/vidas/contVidas/corazon3
@onready var gameOverCartel = $perdiste
@onready var ganasteCartel = $ganaste

func _ready() -> void:
	nuevoJuego()
	#cabeza=load()
	
func nuevoJuego():
	vidas = 3
	termino = false
	ganasteCartel.visible = false
	gameOverCartel.visible = false
	corazon1.visible = true
	corazon2.visible = true
	corazon3.visible = true
	get_tree().paused=false
	get_tree().call_group("segmentos","queue_free")
	puntaje=0
	$barraPuntaje/puntaje.text="PUNTAJE: "+str(puntaje)
	nuevaSerpiente()
	crearComida()
	
func nuevaSerpiente():
	datosViejos.clear()
	datos.clear()
	serpiente.clear()
	for i in range(3):
		nuevoSegmento(posInicio+Vector2(0,i))
		
func nuevoSegmento(pos):
	datos.append(pos)
	var segmentoSerpiente=serpienteEscena.instantiate()
	segmentoSerpiente.position=(pos*tamanioCelda)+Vector2(0,tamanioCelda)
	add_child(segmentoSerpiente)
	serpiente.append(segmentoSerpiente)

func _process(delta: float) -> void:
	mover()
	
func mover():
	if Input.is_action_just_pressed("moverAb") and direccion!=arriba:
		if puedeMoverse:
			direccion=abajo
			puedeMoverse=false
		if not juegoEmpezado:
			iniciar()
	if Input.is_action_just_pressed("moverArr") and direccion!=abajo:
		if puedeMoverse:
			direccion=arriba
			puedeMoverse=false
		if not juegoEmpezado:
			iniciar()
	if Input.is_action_just_pressed("moverI") and direccion!=derecha:
		if puedeMoverse:
			direccion=izquierda
			puedeMoverse=false
		if not juegoEmpezado:
			iniciar()
	if Input.is_action_just_pressed("moverD") and direccion!=izquierda:
		if puedeMoverse:
			direccion=derecha
			puedeMoverse=false
		if not juegoEmpezado:
			iniciar()
			
func iniciar():
	juegoEmpezado=true
	$Timer.start()

func _on_timer_timeout() -> void:
	puedeMoverse=true
	datosViejos=[] + datos
	datos[0]+=direccion
	for i in range(len(datos)):
		if i > 0:
			datos[i]=datosViejos[i - 1]
		serpiente[i].position= (datos[i]*tamanioCelda)+Vector2(0,tamanioCelda)
	chequearEstaEnMapa()
	chequearComida()
	
func chequearEstaEnMapa():
	if datos[0].x<0 or datos[0].x>cantCeldasX-1 or datos[0].y<0 or datos[0].y>cantCeldasY-1:
		restarVida()
		
func restarVida() -> void:
	vidas -= 1
	$Timer.stop()
	juegoEmpezado = false
	puedeMoverse = true
	
	if vidas == 2:
		corazon3.visible = false
	elif vidas == 1:
		corazon2.visible = false
	elif vidas <= 0:
		corazon1.visible = false
		perder()
		return
	
	nuevaSerpiente()
	crearComida()
	
func chequearComida():
	if datos[0]==comidaPos:
		puntaje+=1
		if puntaje == 5:
			ganaste()
		$barraPuntaje/puntaje.text="PUNTAJE: "+str(puntaje)
		nuevoSegmento(datosViejos[-1])
		crearComida()
		
func ganaste() -> void:
	if termino:
		return
	termino = true
	
	$Timer.stop()
	ganasteCartel.visible = true
	
	Progreso.marcarMinijuegoGanado(1)
	if Progreso.datos.nivelDesbloq < 2:
		Progreso.datos.nivelDesbloq = 2
	Progreso.guardarPartida()
		
	await get_tree().create_timer(2.0).timeout 
	get_tree().change_scene_to_file("res://escenas/niveles/nivel_1.tscn")
		
func crearComida():
	while regenerarComida:
		regenerarComida=false
		comidaPos=Vector2(randi_range(0,cantCeldasX-1), randi_range(0,cantCeldasY-1))
		for i in datos:
			if comidaPos==i:
				regenerarComida=true
	$comida.position=(comidaPos*tamanioCelda+Vector2(0, tamanioCelda))
	regenerarComida=true
	
func perder():
	if termino:
		return
	termino = true
	gameOverCartel.visible= true
