extends Area2D
signal recogido
@export var nivel = 1
var tocado = false

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "nani" or body.name == "kiki") and !tocado:
		tocado = true 
		visible = false
		
		Progreso.recogerHueso(nivel)
		emit_signal("recogido")
		
		if Progreso.ganoJuegoCompleto():
			get_tree().change_scene_to_file("res://escenas/ganaste.tscn")
		else:
			await get_tree().create_timer(2.0).timeout # Espera tranquila de 2 seg
			print(str(Progreso.datos.huesitosRecolectado) + "/4 recolectado") 
			get_tree().change_scene_to_file("res://escenas/niveles.tscn") 	
		queue_free()
