extends CharacterBody2D

const SPEED = 800.0

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED 
	
	move_and_slide() 
	
	var screen_width := get_viewport_rect().size.x
	position.x = clamp(position.x, 50, screen_width - 50)
