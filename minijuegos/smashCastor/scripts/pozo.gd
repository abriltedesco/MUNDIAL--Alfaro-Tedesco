extends Area2D

signal golpeado(esHueso: bool)

@onready var spriteHueso = $hueso
@onready var spriteArdilla = $squirrel

var tweenActual: Tween = null
var arriba = false
var muestraHueso = false

func _ready():
	input_pickable = true
	
	spriteHueso.visible = false
	spriteArdilla.visible = false
	spriteHueso.position.y = 0
	spriteArdilla.position.y = 0
	
func asomarse(esHueso:bool) -> void:
	if arriba:
		return
		
	arriba = true
	muestraHueso = esHueso
	
	var objeto
	if muestraHueso:
		objeto = spriteHueso
	else:
		objeto = spriteArdilla
	
	objeto.visible = true
	objeto.position.y = 0
	
	if tweenActual:
		tweenActual.kill()
		
	var tween = create_tween()
	tween.tween_property(objeto, "position:y", -40, 0.08).set_trans(Tween.TRANS_SINE)
	tween.tween_interval(0.50)
	tween.tween_property(objeto, "position:y", 0, 0.08).set_trans(Tween.TRANS_SINE)
	tween.tween_callback(esconderse)

func esconderse() -> void:
	arriba = false
	spriteHueso.visible = false
	spriteArdilla.visible = false
	spriteHueso.position.y = 0
	spriteArdilla.position.y = 0
	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if arriba:
			golpeado.emit(muestraHueso)
			esconderse()
