extends Control

@onready var exit_button = $Button

var answer_container : Node
var answer_buttons = []

var question : String
var answer_a : String
var answer_b : String
var answer_c : String
var answer_d : String
var correct_answer : int
var correct_answer_text : String
var expanded_answer : String
var question_number : int

func _ready() -> void:
	QuizManager.domain_changed.connect(rewrite_question_and_answers)
	
	answer_container = $ColorRect/VBoxContainer/HBoxContainer/Answers_GridContainer
	
	answer_buttons.append($ColorRect/VBoxContainer/HBoxContainer/Answers_GridContainer/ButtonA)
	answer_buttons.append($ColorRect/VBoxContainer/HBoxContainer/Answers_GridContainer/ButtonB)
	answer_buttons.append($ColorRect/VBoxContainer/HBoxContainer/Answers_GridContainer/ButtonC)
	
	match correct_answer:
		0:
			correct_answer_text = answer_a
		1:
			correct_answer_text = answer_b
		2:
			correct_answer_text = answer_c
	
	$ColorRect2/VBoxContainer/CorrectAnswer.text = correct_answer_text
	shuffle_buttons()

func write_question_and_answers() -> void:
	$ColorRect/VBoxContainer/HBoxContainer2/Question.text = question

	$ColorRect/VBoxContainer/HBoxContainer/Answers_GridContainer/ButtonA.text = tr(answer_a)
	$ColorRect/VBoxContainer/HBoxContainer/Answers_GridContainer/ButtonB.text = tr(answer_b)
	$ColorRect/VBoxContainer/HBoxContainer/Answers_GridContainer/ButtonC.text = tr(answer_c)
	
	$ColorRect2/VBoxContainer/RichTextLabel.text = expanded_answer

func rewrite_question_and_answers() -> void:
	tr($ColorRect/VBoxContainer/HBoxContainer2/Question.text)


func update_question_number(q_number : int) -> void:
	$ColorRect/VBoxContainer/HBoxContainer2/Control/Number.text = str(q_number)
	pass
	
func shuffle_buttons() -> void:
	var rng = RandomNumberGenerator.new()
	for i in answer_buttons.size():
		answer_container.move_child(answer_buttons[i], rng.randi_range(0,answer_buttons.size()-1))
	pass
	
func update_answer_colorrect_position(update_to_center: bool) -> void:
	if update_to_center:
		$ColorRect2.position = Vector2(0,0)
	else:
		$ColorRect2.position = Vector2(get_viewport_rect().size.x,0)

func _on_button_a_button_up() -> void:
	check_for_answer(0)
	EventManager.dither_screen()
	update_answer_colorrect_position(true)
func _on_button_b_button_up() -> void:
	check_for_answer(1)
	EventManager.dither_screen()
	update_answer_colorrect_position(true)
func _on_button_c_button_up() -> void:
	check_for_answer(2)
	EventManager.dither_screen()
	update_answer_colorrect_position(true)
func _on_button_d_button_up() -> void:
	check_for_answer(3)
	EventManager.dither_screen()
	update_answer_colorrect_position(true)

func check_for_answer(answer : int) -> void:
	if answer == correct_answer:
		$ColorRect2/VBoxContainer/Answer.text = "CORRECT"
		$ColorRect2/VBoxContainer/Answer.add_theme_color_override("font_color", Color(0.224, 0.403, 0.195))
		QuestionsLoader.correct_answers += 1
		EventManager.question_answered.emit(true)
	else:
		$ColorRect2/VBoxContainer/Answer.text = "INCORRECT"
		$ColorRect2/VBoxContainer/Answer.add_theme_color_override("font_color", Color(0.502, 0.092, 0.135))
		EventManager.question_answered.emit(false)

func _on_next_button_button_up() -> void:
	update_answer_colorrect_position(false)
	QuestionsLoader.load_next_question()

func _on_exit_button_button_up() -> void:
	EventManager.dither_screen()
	QuestionsLoader.reset_questions()
