extends Node

signal questions_ended
signal questions_reloaded

var question_screen = preload("res://scenes/question_screen.tscn")

var question_data_filepath : String = "res://questions.json"
var number_of_questions : int

var question_array = []
var next_question : int = 0

var correct_answers : int = 0

var questions_are_on : bool = false

func _ready() -> void:
	question_array = load_questions()
	
func load_questions() -> Array:
	var questions
	var loaded_questions = []
	var q_int : int = 1
	if QuestionsLoader.load_question():
		questions = QuestionsLoader.load_question()
		for q in questions:
			var _question_screen = question_screen.instantiate()
			_question_screen.question = questions[q]["question"]
			_question_screen.answer_a = questions[q]["answer a"]
			_question_screen.answer_b = questions[q]["answer b"]
			_question_screen.answer_c = questions[q]["answer c"]
			_question_screen.correct_answer = questions[q]["correct answer"]
			_question_screen.expanded_answer = questions[q]["expanded answer"]
			_question_screen.question_number = q_int
			q_int += 1
			_question_screen.write_question_and_answers()
			loaded_questions.append(_question_screen)
	else:
		print("Couldn't load questions.")
	return loaded_questions
	
func load_question():
	if FileAccess.file_exists(question_data_filepath):
		var file = FileAccess.open(question_data_filepath, FileAccess.READ)
		var json = JSON.new()
		var error = json.parse(file.get_as_text())
		if error == OK:
			var saved_data = json.data
			if typeof(saved_data) == TYPE_DICTIONARY:
				#print(saved_data) # Prints dictionary
				number_of_questions = saved_data.size()
				return(saved_data)
			else:
				print("Unexpected data")
		else:
			print("JSON Parse Error: ", json.get_error_message(), " in ", file.get_as_text(), " at line ", json.get_error_line())
	else:
		print("File does not exist!")
		
func load_next_question() -> void:
	if next_question < question_array.size():
		questions_are_on = true
		EventManager.dither_screen()
		get_parent().add_child(QuestionsLoader.question_array[QuestionsLoader.next_question])
		if next_question > 0:
			get_parent().remove_child(QuestionsLoader.question_array[QuestionsLoader.next_question-1])
		next_question += 1
	else:
		get_parent().remove_child(QuestionsLoader.question_array[QuestionsLoader.next_question-1])
		questions_are_on = false
		questions_ended.emit()

func reset_questions() -> void:
	next_question = 0
	correct_answers = 0
	for q in question_array:
		q.queue_free()
	question_array = load_questions()
	questions_reloaded.emit()
