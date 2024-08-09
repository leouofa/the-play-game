extends Control

const LEVEL_SCENE_PATH = "res://scenes/levels/level"
const UI_SCENE_PATH = "res://scenes/ui/"
const SAVE_PATH = "user://save_slot_"

var game_data = {}

func goto_level(level):
	var scene_file = LEVEL_SCENE_PATH + level + ".tscn"
	get_tree().change_scene_to_file(scene_file)

func goto_ui_scene(scene):
	var scene_file = UI_SCENE_PATH + scene + ".tscn"
	get_tree().change_scene_to_file(scene_file)

func load_data(save_slot):
	if slot_exists(save_slot):
		var file_path = SAVE_PATH + str(save_slot) + ".save"
		var savefile = FileAccess.open(file_path, FileAccess.READ)
		game_data = savefile.get_var(true)


func slot_exists(save_slot):
	var file_path = SAVE_PATH + str(save_slot) + ".save"
	return FileAccess.file_exists(file_path)
