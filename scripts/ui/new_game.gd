extends Control

const SAVE_PATH = "user://save_slot_"

var slot1
var slot2
var slot3
var game_data = {}

func _ready():
	slot1 = $VBoxContainer/SlotOne
	slot2 = $VBoxContainer/SlotTwo
	slot3 = $VBoxContainer/SlotThree

	for i in range(1, 4):  # range(start, end) where end is exclusive
		var slot_name = "slot" + str(i)
		var slot_variable = get(slot_name)

		if slot_exists(i):
			load_data(i)
			slot_variable.set_text(game_data.username)
		else:
			slot_variable.set_text("Empty")

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")


func _on_slot_one_pressed():
	Autoload.slot = 1
	get_tree().change_scene_to_file("res://scenes/ui/player_name.tscn")


func _on_slot_two_pressed():
	Autoload.slot = 2
	get_tree().change_scene_to_file("res://scenes/ui/player_name.tscn")


func _on_slot_three_pressed():
	Autoload.slot = 3
	get_tree().change_scene_to_file("res://scenes/ui/player_name.tscn")

	# save(3)

func save(save_slot):
	var file = FileAccess.open(SAVE_PATH + str(save_slot) + ".save", FileAccess.WRITE)
	var slot_name = "Slot " + str(save_slot)
	file.store_var(slot_name)
	file.close()

func load_data(save_slot):
	if slot_exists(save_slot):
		var file_path = SAVE_PATH + str(save_slot) + ".save"
		var savefile = FileAccess.open(file_path, FileAccess.READ)
		game_data = savefile.get_var(true)


func slot_exists(save_slot):
	var file_path = SAVE_PATH + str(save_slot) + ".save"
	return FileAccess.file_exists(file_path)
	


		
