extends CharacterBody2D
@onready var animacion = $AnimatedSprite2D
@onready var sonido = $sonidosPerro
var movIntro = false
const SPEED = 200.0 

func _ready() -> void:
	animacion.play("default")

func _physics_process(delta: float) -> void:
	if !movIntro:
		moverse()
	
func moverse() -> void:
	$AnimatedSprite2D.scale = Vector2(4.0, 4.0)
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
	$AnimatedSprite2D.play(nombreAnimacion)
	
	if nombreAnimacion == "llorando" or nombreAnimacion == "triste" or nombreAnimacion == "dejaDeLlorar":
		$AnimatedSprite2D.scale = Vector2(0.2, 0.2)
	else:
		$AnimatedSprite2D.scale = Vector2(4.0, 4.0) 
		
func playSonido(nombre) -> void:
	sonido.playSonido(nombre)
	
func detenerCaminata() -> void:
	sonido.detenerCaminar()
