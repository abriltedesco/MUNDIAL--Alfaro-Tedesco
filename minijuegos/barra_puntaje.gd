extends CanvasLayer

@onready var puntaje = $puntaje
@onready var corazon1 = $vidas/contVidas/corazon1
@onready var corazon2 = $vidas/contVidas/corazon2
@onready var corazon3 = $vidas/contVidas/corazon3

func set_puntaje(valor: int) -> void:
	puntaje.text = "PUNTAJE: " + str(valor)

func set_vidas(valor: int) -> void:
	corazon1.visible = valor >= 1
	corazon2.visible = valor >= 2
	corazon3.visible = valor >= 3

func ocultar() -> void:
	puntaje.visible = false
