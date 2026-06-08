extends Area2D

@export var escena = ""
@export var banderaSprite = ""
@export var banderaSpriteBloqueada = ""
@export var nivel = 1
var bloqueada = false

func _ready() -> void:
	if banderaSprite != "":
		$Sprite2D.texture = load(banderaSprite)
		
	if nivel > 0 and Progreso.datos.get("ganadosDificil") != null and Progreso.datos.get("ganadosDificil").has(nivel):
		bloquear()
		
func bloquear() -> void:
	bloqueada = true
	$CollisionShape2D.disabled = true
	if banderaSpriteBloqueada != "":
		$Sprite2D.texture = load(banderaSpriteBloqueada)
		
func _on_body_entered(body: Node2D) -> void:
	if body.name != "avion": 
		return
	if bloqueada: 
		return
	var ruta_limpia = escena.replace("\"", "").replace("'", "").strip_edges()
	if ruta_limpia != "":
		if ResourceLoader.exists(ruta_limpia):
			$CollisionShape2D.set_deferred("disabled", true)
			Progreso.modoDificil = true
			
			var error = get_tree().change_scene_to_file(ruta_limpia)
			if error != OK:
				print("erroorrrrr", error)
