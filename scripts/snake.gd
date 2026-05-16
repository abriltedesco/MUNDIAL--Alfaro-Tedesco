extends Node2D
@export var serpienteEscena:PackedScene
var puntaje:int
var juegoEmpezado:bool=false
var cantCeldasX:int=20
var cantCeldasY:int=15
var tamanioCelda:int=50 #en pixeles

#serpiente
var datosViejos:Array
var datos:Array
var serpiente: Array
var posInicio=Vector2(9,2)
var arriba=Vector2(0,1)
var abajo=Vector2(-1,0)
var derecha=Vector2(1,0)
var izquierda=Vector2(1,1)
var direccion:Vector2
var seMueve:bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	iniciar()
	
func iniciar() -> void:
	puntaje=0
	$barraPuntaje.get_node("Label").text="PUNTAJE: "+str(puntaje)
	direccion=arriba
	nuevaSerpiente()
	
func nuevaSerpiente() -> void:
	datosViejos.clear()
	datos.clear()
	serpiente.clear()
	for i in range(3):
		nuevoSegmento(posInicio+Vector2(0,i))
		
func nuevoSegmento(pos) -> void:
	datos.append(pos)
	var segmentoSerpiente=serpienteEscena.instantiate()
	segmentoSerpiente.position=(pos*tamanioCelda)+Vector2(0,tamanioCelda)
	add_child(segmentoSerpiente)
	serpiente.append(segmentoSerpiente)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
