extends Control

signal start_button_pressed

func _on_button_button_up() -> void:
	start_button_pressed.emit()
