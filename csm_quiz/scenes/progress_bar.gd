extends Control

@onready var progress_bar := get_node_or_null("TextureProgressBar") as TextureProgressBar

func _ready() -> void:
	EventManager.question_answered.connect(on_question_answered)
	QuestionsLoader.questions_ended.connect(on_questions_ended)
	progress_bar.step = progress_bar.max_value / QuestionsLoader.number_of_questions
	
func on_question_answered(_correct : bool) -> void:
	progress_bar.value += progress_bar.step
	pass

func on_questions_ended() -> void:
	progress_bar.value = progress_bar.min_value
	pass
