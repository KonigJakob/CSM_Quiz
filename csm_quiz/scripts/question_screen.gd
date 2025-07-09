extends Control

var answer_buttons = []

var question : String
var answer_a : String
var answer_b : String
var answer_c : String
var answer_d : String
var correct_answer : int
var expanded_answer : String

func _ready() -> void:
	answer_buttons.append($ColorRect/VBoxContainer/HBoxContainer/Answers_GridContainer/ButtonA)
	answer_buttons.append($ColorRect/VBoxContainer/HBoxContainer/Answers_GridContainer/ButtonB)
	answer_buttons.append($ColorRect/VBoxContainer/HBoxContainer/Answers_GridContainer/ButtonC)
	answer_buttons.append($ColorRect/VBoxContainer/HBoxContainer/Answers_GridContainer/ButtonD)

func write_question_and_answers() -> void:
	$ColorRect/VBoxContainer/HBoxContainer2/Question.text = question

	$ColorRect/VBoxContainer/HBoxContainer/Answers_GridContainer/ButtonA.text = answer_a
	$ColorRect/VBoxContainer/HBoxContainer/Answers_GridContainer/ButtonB.text = answer_b
	$ColorRect/VBoxContainer/HBoxContainer/Answers_GridContainer/ButtonC.text = answer_c
	$ColorRect/VBoxContainer/HBoxContainer/Answers_GridContainer/ButtonD.text = answer_d
	
	$ColorRect2/VBoxContainer/RichTextLabel.text = expanded_answer
	
func update_answer_colorrect_position(update_to_center: bool) -> void:
	if update_to_center:
		$ColorRect2.position = Vector2(0,0)
	else:
		$ColorRect2.position = Vector2(get_viewport_rect().size.x,0)

func _on_button_a_button_up() -> void:
	check_for_answer(0)
	update_answer_colorrect_position(true)
func _on_button_b_button_up() -> void:
	check_for_answer(1)
	update_answer_colorrect_position(true)
func _on_button_c_button_up() -> void:
	check_for_answer(2)
	update_answer_colorrect_position(true)
func _on_button_d_button_up() -> void:
	check_for_answer(3)
	update_answer_colorrect_position(true)

func check_for_answer(answer : int) -> void:
	if answer == correct_answer:
		$ColorRect2/VBoxContainer/Answer.text = "CORRECT"
		$ColorRect2.color = Color.GREEN
		QuestionsLoader.correct_answers += 1
		EventManager.question_answered.emit(true)
	else:
		$ColorRect2/VBoxContainer/Answer.text = "INCORRECT"
		$ColorRect2.color = Color.ORANGE_RED
		EventManager.question_answered.emit(false)

func _on_next_button_button_up() -> void:
	update_answer_colorrect_position(false)
	QuestionsLoader.load_next_question()
	
