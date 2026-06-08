extends Area2D

var velocidadCaida:float=300.0
@export var esBueno: bool=true
var spritesBuenos: Array = ["croissant", "torta", "cafe"]
var spritesMalos: Array  = ["malo1", "malo2"]

func _ready() -> void:
	for obj in spritesBuenos + spritesMalos:
		get_node(obj).visible = false
	var lista: Array = spritesBuenos if esBueno else spritesMalos
	get_node(lista[randi() % lista.size()]).visible = true
	if Progreso.modoDificil:
		velocidadCaida = 480.0
	if esBueno:
		add_to_group("objetoBueno")
	else:
		add_to_group("objetoMalo")
func _process(delta: float) -> void:
	position.y+=velocidadCaida*delta
	if position.y>get_viewport_rect().size.y+20:
		queue_free()
