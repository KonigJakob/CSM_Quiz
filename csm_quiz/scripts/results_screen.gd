extends Control

var correct_answers_label
var displayed_results : int = 0
@export var animation_speed : float = 0.1
var home_button
var counting_can_start : bool

func _ready() -> void:
	correct_answers_label = $ColorRect/Label/Label
	home_button = $ColorRect/Button
	QuestionsLoader.questions_ended.connect(on_questions_ended)

func show_results(total_correct: int) -> void:
	displayed_results = 0
	correct_answers_label.text = str(displayed_results)
	
	# Create and configure the tween
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_method(_update_displayed_score, 0, total_correct, animation_speed)
	tween.set_parallel(false)
	tween.tween_property($ColorRect/Label/Label, "scale", Vector2(2.5,2.5), 0)
	tween.set_parallel(false)
	tween.tween_callback(call_chromatic_aberration)
	tween.set_parallel(false)
	tween.tween_property($ColorRect/Label/Label, "scale", Vector2(1.5,1.5), 0).set_delay(1)
	

func call_chromatic_aberration() -> void:
	EventManager.add_chromatic_aberration()

func _update_displayed_score(value: int):
	displayed_results = value
	correct_answers_label.text = str(displayed_results)

func on_questions_ended() -> void:
	show_results(QuestionsLoader.correct_answers)

func _on_button_button_up() -> void:
	QuestionsLoader.reset_questions()
	visible = false
