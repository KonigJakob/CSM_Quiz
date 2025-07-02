extends Control

var correct_answers_label
var home_button

func _ready() -> void:
	correct_answers_label = $ColorRect/Label/Label
	home_button = $ColorRect/Button
	QuestionsLoader.questions_ended.connect(on_questions_ended)
	
func on_questions_ended() -> void:
	correct_answers_label.text = str(QuestionsLoader.correct_answers)

func _on_button_button_up() -> void:
	QuestionsLoader.reset_questions()
	visible = false
