extends Area2D

@export var escena= ""
@export var banderaSprite = ""

func _ready() -> void:
	if banderaSprite != "":
		$Sprite2D.texture = load(banderaSprite)

func _on_body_entered(body: Node2D) -> void:
	if body.name != "avion":
		return

	
	if escena != "":
		get_tree().change_scene_to_file(escena)
