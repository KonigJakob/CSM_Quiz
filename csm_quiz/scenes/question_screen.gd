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
	
func update_answer_colorrect_position() -> void:
	$ColorRect2.position = Vector2(0,0)

func _on_button_a_button_up() -> void:
	if correct_answer == answer_buttons.find($ColorRect/VBoxContainer/HBoxContainer/Answers_GridContainer/ButtonA):
		$ColorRect2/VBoxContainer/Answer.text = "Correct!"
		$ColorRect2.color = Color.GREEN
		QuestionsLoader.correct_answers += 1
	else:
		$ColorRect2/VBoxContainer/Answer.text = "Incorrect!"
		$ColorRect2.color = Color.ORANGE_RED
	update_answer_colorrect_position()
func _on_button_b_button_up() -> void:
	if correct_answer == answer_buttons.find($ColorRect/VBoxContainer/HBoxContainer/Answers_GridContainer/ButtonB):
		$ColorRect2/VBoxContainer/Answer.text = "Correct!"
		$ColorRect2.color = Color.GREEN
		QuestionsLoader.correct_answers += 1
	else:
		$ColorRect2/VBoxContainer/Answer.text = "Incorrect!"
		$ColorRect2.color = Color.ORANGE_RED
	update_answer_colorrect_position()
func _on_button_c_button_up() -> void:
	if correct_answer == answer_buttons.find($ColorRect/VBoxContainer/HBoxContainer/Answers_GridContainer/ButtonC):
		$ColorRect2/VBoxContainer/Answer.text = "Correct!"
		$ColorRect2.color = Color.GREEN
		QuestionsLoader.correct_answers += 1
	else:
		$ColorRect2/VBoxContainer/Answer.text = "Incorrect!"
		$ColorRect2.color = Color.ORANGE_RED
	update_answer_colorrect_position()
func _on_button_d_button_up() -> void:
	if correct_answer == answer_buttons.find($ColorRect/VBoxContainer/HBoxContainer/Answers_GridContainer/ButtonD):
		$ColorRect2/VBoxContainer/Answer.text = "Correct!"
		$ColorRect2.color = Color.GREEN
		QuestionsLoader.correct_answers += 1
	else:
		$ColorRect2/VBoxContainer/Answer.text = "Incorrect!"
		$ColorRect2.color = Color.ORANGE_RED
	update_answer_colorrect_position()

func _on_next_button_button_up() -> void:
	QuestionsLoader.load_next_question()
