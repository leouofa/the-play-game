extends Control

const SAVE_PATH = "user://save_slot_"
var warning_label
var warning_text
var name_input

func _ready():
	warning_label = $VBoxContainer/WarningLabel
	warning_text = $VBoxContainer/WarningText
	name_input = $VBoxContainer/NameInput

	if slot_exists(Autoload.slot):
		warning_label.visible = true
		warning_text.visible = true
	else:
		print("slot is empty")

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/new_game.tscn")

func slot_exists(save_slot):
	var file_path = SAVE_PATH + str(save_slot) + ".save"
	return FileAccess.file_exists(file_path)


func _on_new_game_button_pressed():
	# print(username.text)
	save(Autoload.slot)

func save(save_slot):
	var file = FileAccess.open(SAVE_PATH + str(save_slot) + ".save", FileAccess.WRITE)
	var username = name_input.text
	file.store_var(username)
	file.close()
