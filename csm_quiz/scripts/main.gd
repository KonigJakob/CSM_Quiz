extends Control

@onready var start_screen = $StartScreen
@onready var results_screen = $ResultsScreen
@onready var progress_bar = $CanvasLayer/ProgressBar
@onready var auto_exit_timer = $AutoExitTimer
@onready var effect_timer = $EffectTimer

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
	
func on_questions_ended() -> void:
	results_screen.visible = true
	progress_bar.visible = false

func _on_timer_timeout() -> void:
	EventManager.add_chromatic_aberration() 

func _on_auto_exit_timer_timeout() -> void:
	#implement idle
	pass
