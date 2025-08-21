extends Node

signal set_changed

var language_keys = ["en", "fr", "de"]  # logical languages
var question_sets = {
	KEY_F1: {"en":"en", "fr":"fr", "de":"de"},
	KEY_F2: {"en":"es", "fr":"fro", "de":"del"},
	KEY_F3: {"en":"eo", "fr":"fi", "de":"den"}
	}
var current_set : int = KEY_F1
var current_language : String = "en"  # logical language key

func _ready() -> void:
	LoadPrefs()

func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode in question_sets:
			switch_question_set(event.keycode)

func switch_question_set(key : int) -> void:
	current_set = key
	var new_locale = question_sets[current_set][current_language]
	TranslationServer.set_locale(new_locale)
	set_changed.emit()
	QuestionsLoader.reset_questions()
	SavePrefs()

func set_language(lang : String) -> void:
	current_language = lang
	var new_locale = question_sets[current_set][current_language]
	TranslationServer.set_locale(new_locale)
	QuestionsLoader.reset_questions()
	SavePrefs()
	
func SavePrefs() -> void:
	var configFile = ConfigFile.new()
	configFile.set_value("Admin", "Set", current_set)
	configFile.set_value("Admin", "Language", current_language)
	configFile.save("user://configFile.cfg")
	pass

func LoadPrefs() -> void:
	var configFile = ConfigFile.new()
	# Load data from a file.
	var err = configFile.load("user://configFile.cfg")
	# If the file didn't load, ignore it.
	if err != OK:
		print("Prefs loaded unsuccesfully.")
		return
	current_language = configFile.get_value("Admin", "Language")
	current_set = configFile.get_value("Admin", "Set")
	switch_question_set(current_set)
	set_language(current_language)
	print("Prefs loaded succesfully.")
