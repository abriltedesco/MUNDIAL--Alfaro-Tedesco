extends CharacterBody2D
@onready var animacion = $AnimatedSprite2D
var movIntro = false
const SPEED = 200.0 

func _ready() -> void:
	animacion.play("default")

func _physics_process(delta: float) -> void:
	if !movIntro:
		moverse()
	
func moverse() -> void:
	var dir = Vector2.ZERO
	if Input.is_action_pressed("moverD"):
		dir.x += 1
		animacion.flip_h = false
		animacion.play("walkR")
	elif Input.is_action_pressed("moverI"):
		dir.x -= 1
		animacion.flip_h = true
		animacion.play("walkR")
	elif Input.is_action_pressed("moverAb"):
		dir.y += 1
		animacion.play("walkF")
	elif Input.is_action_pressed("moverArr"):
		dir.y -= 1
		animacion.play("walkB")
		
	if dir == Vector2.ZERO:
		animacion.play("default")
		
	velocity = dir.normalized() * SPEED
	move_and_slide()

func play(nombreAnimacion: String) -> void:
	animacion.play(nombreAnimacion)
