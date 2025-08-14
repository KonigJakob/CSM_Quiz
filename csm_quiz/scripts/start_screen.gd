extends Control

signal start_button_pressed	

func _on_button_button_up() -> void:
	start_button_pressed.emit()
	QuizManager.can_switch_set = false

func _on_de_button_button_up() -> void:
	QuizManager.set_language("de")
	QuestionsLoader.reset_questions()

func _on_en_button_button_up() -> void:
	QuizManager.set_language("en")
	QuestionsLoader.reset_questions()

func _on_fr_button_button_up() -> void:
	QuizManager.set_language("fr")
	QuestionsLoader.reset_questions()
