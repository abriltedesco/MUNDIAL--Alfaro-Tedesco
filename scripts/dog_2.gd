extends CharacterBody2D


func play(nombreAnimacion: String) -> void:
	$AnimatedSprite2D.play(nombreAnimacion)
	
	if nombreAnimacion == "llorando" or nombreAnimacion == "triste":
		$AnimatedSprite2D.scale = Vector2(0.13, 0.13)
	else:
		$AnimatedSprite2D.scale = Vector2(4.0, 4.0) 
