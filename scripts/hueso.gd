extends Area2D
signal recogido
@export var nivel = 1

func _on_body_entered(body: Node2D) -> void:
	Progreso.recogerHueso(nivel)
		
	if Progreso.ganoJuegoCompleto():
		print("Ganaste el juego!!")
		# desp seguro aca tendra una escena mejor para el fin del juego
	
	emit_signal("recogido")
	queue_free() 
