extends Node2D
@onready var animacion = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animacion.play("default")
	moverse()

func moverse() -> void:
	var dir = Vector2.ZERO
	
	if Input.is_action_pressed("moverD"):
		animacion.play("walkR")
		dir = Vector2.RIGHT
	elif Input.is_action_pressed("moverI"):
		animacion.flip_h
		animacion.play("walkR")
		dir = Vector2.LEFT
	elif Input.is_action_pressed("moverAb"):
		
		dir = Vector2.DOWN
	elif Input.is_action_pressed("moverArr"):
		animacion.play("walkB")
		dir = Vector2.UP
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
