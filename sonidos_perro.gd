extends Node

const SONIDOS = {
	"ladrar": preload("res://assets/sonidps/ladrido.mp3"),
	"feliz": preload("res://assets/sonidps/feliz.wav"),
	"triste": preload("res://assets/sonidps/triste.mp3"),
	"caminando": preload("res://assets/sonidps/caminando.mp3")
}

@onready var sfx:AudioStreamPlayer2D = $SfxPerro
@onready var caminando:AudioStreamPlayer2D = $WalkPerro

func playSonido(nombre: String) -> void:
	if !SONIDOS.has(nombre): return
	
	if nombre == "caminando":
		if !caminando.playing:
			caminando.stream = SONIDOS[nombre]
			caminando.play()
	else:
		sfx.stream = SONIDOS[nombre]
		sfx.play()

func detenerCaminar() -> void:
	caminando.stop()
