extends Node

signal domain_changed

var current_set : int = 0

@export var set_a : Array[OptimizedTranslation]
@export var set_b : Array[OptimizedTranslation]
@export var set_c : Array[OptimizedTranslation]

var set_a_domain : TranslationDomain
var set_b_domain : TranslationDomain
var set_c_domain : TranslationDomain

func _ready() -> void:
	set_a_domain = init_domain("set_a", set_a)
	set_b_domain = init_domain("set_b", set_b)
	set_c_domain = init_domain("set_c", set_c)
	TranslationServer.set_translation_domain("set_a")

func init_domain(domain_name : String, domain_array : Array) -> TranslationDomain:
	var domain = TranslationServer.get_or_add_domain(domain_name)
	for t in domain_array:
		domain.add_translation(t)
	return domain

func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_F1:
			switch_question_set("set_a")
		elif event.pressed and event.keycode == KEY_F2:
			switch_question_set("set_b")
		elif event.pressed and event.keycode == KEY_F3:
			switch_question_set("set_c")
		elif event.pressed and event.keycode == KEY_F5:
			pass

func switch_question_set(question_set : String) -> void:
	if TranslationServer.get_translation_domain() == question_set:
		print("Current Set " + TranslationServer.get_translation_domain() + " matches domain.")
		return
	else:
		match question_set:
			"set_a":
				TranslationServer.set_translation_domain("set_a")
				print("Domain changed succesfully")
			"set_b":
				TranslationServer.set_translation_domain("set_b")
				print("Domain changed succesfully")
			"set_c":
				TranslationServer.set_translation_domain("set_c")
				print("Domain changed succesfully")
			_:
				print("Question Set was not changed.")
		print("Current Set: " + TranslationServer.get_translation_domain())
		print("Current Locale: " + TranslationServer.get_locale())
		domain_changed.emit()
		print(domain_changed.get_connections())
