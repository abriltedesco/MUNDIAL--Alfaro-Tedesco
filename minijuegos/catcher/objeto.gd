extends Area2D

var velocidadCaida:float=300.0
@export var esBueno: bool=true

func _ready() -> void:
	$bueno.visible=esBueno
	$malo.visible=!esBueno
	
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
