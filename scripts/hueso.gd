extends Area2D
signal recogido
@export var nivel = 1

func _on_body_entered(body: Node2D) -> void:
	Progreso.recogerHueso(nivel)
	emit_signal("recogido")
		
	if Progreso.ganoJuegoCompleto():
		print("Ganaste el juego!!")
		get_tree().change_scene_to_file("res://escenas/ganaste.tscn")
	else:
		await get_tree().create_timer(2.0).timeout # para q no sea tan rapido el cambio
		print(str(Progreso.datos.huesitosRecolectado) + "/4 recolectado") # aca deberiamos desp ponerle mas q un print algun cartelito 
		get_tree().change_scene_to_file("res://escenas/niveles.tscn") 
	queue_free()
