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
var comidaPos:Vector2
var regenerarComida: bool=true
var puntosParaGanar:int 

@onready var gameOverCartel = $perdiste
@onready var ganasteCartel = $ganaste
@onready var barra_puntaje: BarraPuntaje = $barraPuntaje

func _ready() -> void:
	if Progreso.modoDificil:
		$Timer.wait_time = 0.08 
		puntosParaGanar = 10
	else:
		$Timer.wait_time = 0.15
		puntosParaGanar = 15
		
	nuevoJuego()
	nuevoJuego()
	
func nuevoJuego():
	vidas = 3
	termino = false
	juegoEmpezado = false
	puedeMoverse = true
	direccion = Vector2.ZERO
	ganasteCartel.visible = false
	gameOverCartel.visible = false
	$comida.visible = true
	barra_puntaje.set_vidas(vidas)
	puntaje=0
	barra_puntaje.set_puntaje(puntaje)
	get_tree().paused=false
	nuevaSerpiente()
	crearComida()
	
func nuevaSerpiente():
	limpiarSerpiente()
	for i in range(3):
		nuevoSegmento(posInicio+Vector2(0,i))

func limpiarSerpiente() -> void:
	for segmento in get_tree().get_nodes_in_group("segmentos"):
		if segmento.get_parent() == self:
			segmento.visible = false
			segmento.queue_free()
	serpiente.clear()
	datos.clear()
	datosViejos.clear()
		
func nuevoSegmento(pos):
	datos.append(pos)
	var segmentoSerpiente=serpienteEscena.instantiate()
	segmentoSerpiente.position=(pos*tamanioCelda)+Vector2(0,tamanioCelda)
	add_child(segmentoSerpiente)
	serpiente.append(segmentoSerpiente)

func _process(delta: float) -> void:
	mover()
	
func mover():
	if termino:
		return
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
	if termino:
		return
	juegoEmpezado=true
	$Timer.start()

func _on_timer_timeout() -> void:
	if termino or datos.is_empty():
		return
	puedeMoverse=true
	datosViejos=[] + datos
	datos[0]+=direccion
	for i in range(len(datos)):
		if i > 0:
			datos[i]=datosViejos[i - 1]
		serpiente[i].position= (datos[i]*tamanioCelda)+Vector2(0,tamanioCelda)
	chequearEstaEnMapa()
	if termino or not juegoEmpezado or datos.is_empty():
		return
	chequearComida()
	
func chequearEstaEnMapa():
	if datos.is_empty():
		return
	if datos[0].x<0 or datos[0].x>cantCeldasX-1 or datos[0].y<0 or datos[0].y>cantCeldasY-1:
		restarVida()
		
func restarVida() -> void:
	$restaPunto.play()
	vidas -= 1
	$Timer.stop()
	juegoEmpezado = false
	puedeMoverse = true
	
	barra_puntaje.set_vidas(vidas)
	
	if vidas <= 0:
		perder()
		return
	
	nuevaSerpiente()
	crearComida()
	
func chequearComida():
	if termino or datos.is_empty():
		return
	if datos[0]==comidaPos:
		puntaje+=1
		$sumaPunto.play()
		barra_puntaje.set_puntaje(puntaje)
		if puntaje == puntosParaGanar:
			ganaste()
			return
		nuevoSegmento(datosViejos[-1])
		crearComida()
		
func ganaste() -> void:
	if termino:
		return
	termino = true
	
	$Timer.stop()
	ganasteCartel.visible = true
	
	Progreso.marcarMinijuegoGanado(1)
		
	await get_tree().create_timer(2.0).timeout 
	if Progreso.modoDificil:
		if Progreso.ganoTodosDificiles():
			get_tree().change_scene_to_file("res://escenas/final.tscn")
		else:
			get_tree().change_scene_to_file("res://escenas/niveles_dificiles.tscn")
	else:
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
	juegoEmpezado = false
	puedeMoverse = false
	$Timer.stop()
	limpiarSerpiente()
	$comida.visible = false
	gameOverCartel.visible= true
