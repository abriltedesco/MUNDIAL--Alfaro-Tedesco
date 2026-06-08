extends CharacterBody2D
const SPEED = 250.0
var puedeMoverse = true

func _ready() -> void:
	$sonido.play()

func _physics_process(delta: float) -> void:
	if puedeMoverse:
		var direccion=Input.get_vector("moverI","moverD","moverArr","moverAb")
		velocity = direccion * SPEED
		if direccion!=Vector2.ZERO:
			rotation=direccion.angle()
	move_and_slide()

func detener() -> void:
	puedeMoverse = false
	velocity = Vector2.ZERO
