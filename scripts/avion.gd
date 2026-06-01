extends CharacterBody2D
const SPEED = 250.0
var puedeMoverse = true

func _physics_process(delta: float) -> void:
	if !puedeMoverse:
		velocity = Vector2.ZERO
		move_and_slide()
		return
		
	var dirX = Input.get_axis("moverI", "moverD")
	var dirY = Input.get_axis("moverArr", "moverAb")
	
	velocity = Vector2(dirX, dirY).normalized() * SPEED
	move_and_slide()

func detener() -> void:
	puedeMoverse = false
	velocity = Vector2.ZERO
