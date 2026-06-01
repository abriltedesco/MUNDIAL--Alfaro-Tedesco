extends Area2D

@export var escena= ""
@export var banderaSprite = ""
@export var banderaSpriteBloqueada = ""
@export var nivel = 0

var bloqueada = false

func _ready() -> void:
	if banderaSprite != "":
		$Sprite2D.texture = load(banderaSprite)
		
	if nivel > 0 and Progreso.minijuegoGanado(nivel):
		bloquear()

func _on_body_entered(body: Node2D) -> void:
	if body.name != "avion":
		return
		
	if bloqueada:
		return
	
	if escena != "":
		get_tree().change_scene_to_file(escena)

func bloquear() -> void:
	bloqueada = true
	$CollisionShape2D.disabled = true
	
	if banderaSpriteBloqueada != "":
		$Sprite2D.texture = load(banderaSpriteBloqueada)
