extends Area2D

@export var escena = ""
@export var banderaSprite = ""
@export var banderaSpriteBloqueada = ""
@export var nivel = 0
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
	
	# 1. Limpiamos la ruta por si se pegó con comillas o espacios extra
	var ruta_limpia = escena.replace("\"", "").replace("'", "").strip_edges()
	
	print("¡Contacto! El avión tocó la bandera. Intentando ir a: ", ruta_limpia)
	
	if ruta_limpia != "":
		# 2. Verificamos que el archivo realmente exista en tu computadora
		if ResourceLoader.exists(ruta_limpia):
			
			# Desactivamos la colisión para que no se tilde
			$CollisionShape2D.set_deferred("disabled", true)
			Progreso.modoDificil = true
			
			var error = get_tree().change_scene_to_file(ruta_limpia)
			if error != OK:
				print("ERROR AL CAMBIAR DE ESCENA. Código: ", error)
				
		else:
			print("¡ERROR CRÍTICO! Godot dice que NO EXISTE ninguna escena en esta ruta:")
			print(ruta_limpia)
			print("Revisá que las mayúsculas/minúsculas sean EXACTAMENTE iguales a las de tus carpetas.")
