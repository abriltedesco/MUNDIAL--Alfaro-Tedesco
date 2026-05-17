extends CanvasLayer
signal reempezar


func _on_button_pressed() -> void:
	reempezar.emit()
