extends Control

@onready var start_screen = $StartScreen
@onready var results_screen = $ResultsScreen
@onready var progress_bar = $CanvasLayer/ProgressBar
@onready var auto_exit_timer = $AutoExitTimer
@onready var effect_timer = $EffectTimer

var quiz_started : bool = false

func _ready() -> void:
	QuestionsLoader.questions_ended.connect(on_questions_ended)
	pass

func _input(event):
	if event is InputEventMouseButton:
		auto_exit_timer.start()
		effect_timer.start()

func _on_start_screen_start_button_pressed() -> void:
	QuestionsLoader.load_next_question()
	progress_bar.visible = true
	quiz_started = true
	
func on_questions_ended() -> void:
	results_screen.visible = true
	progress_bar.visible = false

func _on_timer_timeout() -> void:
	EventManager.add_chromatic_aberration() 

func _on_auto_exit_timer_timeout() -> void:
	if quiz_started:
		QuestionsLoader.reset_questions()
		quiz_started = false
	pass

func _on_accessibility_button_up() -> void:
	EventManager.enable_crt()
	EventManager.enable_dithering()
