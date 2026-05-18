extends StaticBody2D

func hit():
	$Sprite2D.visible = false
	$CollisionShape2D.set_deferred("disabled", true)
	await get_tree().create_timer(0.05).timeout
	queue_free()
 
