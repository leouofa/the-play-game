extends Control

const SAVE_PATH = "user://save_slot_"

@onready var	slot1 = $VBoxContainer/SlotOne
@onready var	slot2 = $VBoxContainer/SlotTwo
@onready var	slot3 = $VBoxContainer/SlotThree
var game_data = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(1, 4):  # range(start, end) where end is exclusive
		var slot_name = "slot" + str(i)
		var slot_variable = get(slot_name)

		if slot_exists(i):
			load_data(i)
			slot_variable.set_text(game_data.username)
		else:
			slot_variable.disabled = true


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")


func _on_slot_one_pressed():
	load_data(1)
	change_level()

func _on_slot_two_pressed():
	load_data(2)
	change_level()


func _on_slot_three_pressed():
	load_data(3)
	change_level()

func change_level():
	get_tree().change_scene_to_file("res://scenes/levels/level"+str(game_data.level)+".tscn")


func load_data(save_slot):
	if slot_exists(save_slot):
		var file_path = SAVE_PATH + str(save_slot) + ".save"
		var savefile = FileAccess.open(file_path, FileAccess.READ)
		game_data = savefile.get_var(true)


func slot_exists(save_slot):
	var file_path = SAVE_PATH + str(save_slot) + ".save"
	return FileAccess.file_exists(file_path)
	


		
