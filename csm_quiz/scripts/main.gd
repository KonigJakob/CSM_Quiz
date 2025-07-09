extends Control

@onready var start_screen = $StartScreen
@onready var results_screen = $ResultsScreen
@onready var progress_bar = $CanvasLayer/ProgressBar

func _ready() -> void:
	QuestionsLoader.questions_ended.connect(on_questions_ended)
	pass

func _on_start_screen_start_button_pressed() -> void:
	QuestionsLoader.load_next_question()
	progress_bar.visible = true
	
func on_questions_ended() -> void:
	print("questions ended")
	results_screen.visible = true
	progress_bar.visible = false
	
