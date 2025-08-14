extends Node

signal set_changed

var can_switch_set = true
var current_locale : String = "en"

var language_keys = ["en", "fr", "de"]  # logical languages

var question_sets = {
	KEY_F1: {"en":"en", "fr":"fr", "de":"de"},
	KEY_F2: {"en":"es", "fr":"fro", "de":"del"},
	KEY_F3: {"en":"eo", "fr":"fi", "de":"den"}
	}
var current_set : int = KEY_F1
var current_language : String = "en"  # logical language key


func _unhandled_key_input(event: InputEvent) -> void:
	if can_switch_set and event is InputEventKey:
		if event.keycode in question_sets:
			switch_question_set(event.keycode)
	else:
		print("Can't switch question set now.")

func switch_question_set(key : int) -> void:
	current_set = key
	var new_locale = question_sets[current_set][current_language]
	TranslationServer.set_locale(new_locale)
	set_changed.emit()
	QuestionsLoader.reset_questions()

func set_language(lang : String) -> void:
	current_language = lang
	var new_locale = question_sets[current_set][current_language]
	TranslationServer.set_locale(new_locale)
	QuestionsLoader.reset_questions()
	pass
