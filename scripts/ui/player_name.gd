extends "res://scripts/ui/base.gd"

@onready var warning_label = $VBoxContainer/WarningLabel
@onready var warning_text = $VBoxContainer/WarningText
@onready var name_input = $VBoxContainer/NameInput
@onready var new_game_button = $VBoxContainer/NewGameButton

func _ready():
	name_input.text = "Macron" + str(Autoload.slot)

	if slot_exists(Autoload.slot):
		warning_label.visible = true
		warning_text.visible = true

	new_game_button.grab_focus()

	update_new_game_button_state()
	

func _on_back_button_pressed():
	goto_ui_scene("new_game")

func _on_new_game_button_pressed():
	save(Autoload.slot)
	goto_level('1')

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
