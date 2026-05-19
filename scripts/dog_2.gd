extends CharacterBody2D


func play(nombreAnimacion: String) -> void:
	$AnimatedSprite2D.play(nombreAnimacion)
	
	if nombreAnimacion == "llorando" or nombreAnimacion == "triste":
		$AnimatedSprite2D.scale = Vector2(0.2, 0.2)
	else:
		$AnimatedSprite2D.scale = Vector2(4.0, 4.0) 
