extends Area2D

signal golpeado(esArdilla: bool)

@onready var spriteHoja = $hoja
@onready var spriteArdilla = $squirrel

var tweenActual: Tween = null
var arriba = false
var muestraArdilla = false

func _ready():
	input_pickable = true
	
	spriteHoja.visible = false
	spriteArdilla.visible = false
	spriteHoja.position.y = 0
	spriteArdilla.position.y = 0
	
func asomarse(esArdilla:bool) -> void:
	if arriba:
		return
		
	arriba = true
	muestraArdilla = esArdilla
	
	var objeto
	if muestraArdilla:
		objeto = spriteArdilla
	else:
		objeto = spriteHoja
	
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
	spriteArdilla.visible = false
	spriteHoja.visible = false
	spriteArdilla.position.y = 0
	spriteHoja.position.y = 0
	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if arriba:
			golpeado.emit(muestraArdilla)
			esconderse()
