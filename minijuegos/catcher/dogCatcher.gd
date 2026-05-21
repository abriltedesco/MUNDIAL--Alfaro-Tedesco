extends CharacterBody2D
@onready var animacion = $AnimatedSprite2D
var movIntro = false
const SPEED = 300.0 
signal catchObjetoMalo
signal catchObjetoBueno
@export var vidas:int=3
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
		
	if dir == Vector2.ZERO:
		animacion.play("default")
		
	velocity = dir.normalized() * SPEED
	move_and_slide()

func play(nombreAnimacion: String) -> void:
	animacion.play(nombreAnimacion)
	
func esconderse():
	pass


func _on_area_catch_area_entered(area: Area2D) -> void:
	if area.is_in_group("objetoBueno"):
		emit_signal("catchObjetoBueno")
		area.queue_free()
	if area.is_in_group("objetoMalo"):
		emit_signal("catchObjetoMalo")
		area.queue_free()


func _on_catch_objeto_bueno() -> void:
	pass # Replace with function body.
