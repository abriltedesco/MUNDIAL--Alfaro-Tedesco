extends StaticBody2D

@export var numNivel = 1

func _ready() -> void:
	$Label.mouse_filter = Control.MOUSE_FILTER_IGNORE #para q no bloquee los clics
	input_pickable = true # permiso al candado de escuchar al mouse
	input_event.connect(_on_input_event)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	$Label.text = str(numNivel)
	$spriteCerrado.visible = false
	$spriteAbierto.visible = true
	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# para q no quede la manito flotando en el minijuego.
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		get_tree().change_scene_to_file("res://escenas/niveles/nivel_" + str(numNivel) + ".tscn")
		

func _on_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	
func _on_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
