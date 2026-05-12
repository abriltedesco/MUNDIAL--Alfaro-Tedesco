extends Area2D
signal recogido

func _on_body_entered(body: Node2D) -> void:
	emit_signal("recogido")
	queue_free() 
