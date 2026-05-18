extends Node2D

@onready var kiki = $kiki
@onready var nani = $nani

func _ready() -> void:
	kiki.movIntro = true
	nani.play("sleep")
	kiki.play("walkR")
	
	var tween = create_tween()
	var posNani = Vector2(nani.position.x - 150, nani.position.y)
	tween.tween_property(kiki, "position", posNani, 3.0) 
	await tween.finished
	
	kiki.play("default")
	
	var dialogo = load("res://dialogues/dialogue.dialogue")
	var escenaGlobo = load("res://dialogues/globo_dialogo.tscn").instantiate()
	add_child(escenaGlobo)
	escenaGlobo.start(dialogo, "start", [self])
