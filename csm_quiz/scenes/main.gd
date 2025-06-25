extends Control

@onready var start_screen = $StartScreen
@onready var results_screen = $ResultsScreen

func _ready() -> void:
	QuestionsLoader.questions_ended.connect(on_questions_ended)
	pass

func _on_start_screen_start_button_pressed() -> void:
	QuestionsLoader.load_next_question()
	
func on_questions_ended() -> void:
	results_screen.visible = true
	
