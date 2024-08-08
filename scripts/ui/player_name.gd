extends Control

const SAVE_PATH = "user://save_slot_"

@onready var warning_label = $VBoxContainer/WarningLabel
@onready var warning_text = $VBoxContainer/WarningText
@onready var name_input = $VBoxContainer/NameInput
@onready var new_game_button = $VBoxContainer/NewGameButton

var game_data = {}

func _ready():
	name_input.text = "Macron" + str(Autoload.slot)

	if slot_exists(Autoload.slot):
		warning_label.visible = true
		warning_text.visible = true

	new_game_button.grab_focus()

	update_new_game_button_state()
	

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/new_game.tscn")

func slot_exists(save_slot):
	var file_path = SAVE_PATH + str(save_slot) + ".save"
	return FileAccess.file_exists(file_path)


func _on_new_game_button_pressed():
	save(Autoload.slot)
	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")

func save(save_slot):
	var file_path = SAVE_PATH + str(save_slot) + ".save"
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	var username = name_input.text
	
	game_data = { 
		"username": username,
		"level": 1,
		"scores": { }
	}

	file.store_var(game_data)
	file.close()

func _on_name_input_text_changed(_new_text):
	update_new_game_button_state()

func update_new_game_button_state():
	new_game_button.disabled = name_input.text.length() < 1
