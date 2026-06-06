extends CharacterBody2D

var veloc = 300
var dir = Vector2.DOWN
var activa = true

var vidas = 3
signal vidasPerdidas
signal vidaRestada

var vida_restada = false

func _ready() -> void:
	if Progreso.modoDificil:
		veloc = 600
	velocity = Vector2(veloc* -1, veloc)
	
func restarVida() -> void:
	if vida_restada:
		return

	vida_restada = true
	activa = false
	vidas -= 1

	if vidas <= 0:
		$sonidoGameOver.playing = true
		vidasPerdidas.emit()
	else:
		vidaRestada.emit()
	
func _physics_process(delta: float) -> void:
	if activa:
		var collision = move_and_collide(velocity*delta)
		if collision:
			if collision.get_collider().name == "piso":
				restarVida()
				return
			
			velocity = velocity.bounce(collision.get_normal())
			if collision.get_collider().has_method("hit"):
				$sonidoGolpe.playing = true
				collision.get_collider().hit()
				get_parent().restar_ladrillo()
			
		if (velocity.y > 0 and velocity.y < 100):
			velocity.y = -200; 
		if (velocity.x == 0):
			velocity.y = -200;
	else:
		return
