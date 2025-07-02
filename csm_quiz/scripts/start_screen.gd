extends Control

signal start_button_pressed

func _on_button_button_up() -> void:
	start_button_pressed.emit()

func _on_de_button_button_up() -> void:
	TranslationServer.set_locale("de")

func _on_en_button_button_up() -> void:
	TranslationServer.set_locale("en")
