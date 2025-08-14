extends Control

signal start_button_pressed

func _ready() -> void:
	QuizManager.domain_changed.connect(update_text)
	
func update_text() -> void:
	$ColorRect/Label.text = tr($ColorRect/Label.text)
	print("Text updated?" + $ColorRect/Label.text)

func _on_button_button_up() -> void:
	start_button_pressed.emit()

func _on_de_button_button_up() -> void:
	TranslationServer.set_locale("de")

func _on_en_button_button_up() -> void:
	TranslationServer.set_locale("en")

func _on_fr_button_button_up() -> void:
	TranslationServer.set_locale("fr")
