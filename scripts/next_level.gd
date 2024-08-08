extends Area2D

const FILE_BEGIN = "res://scenes/levels/level"
const SAVE_PATH = "user://save_slot_"

var game_data = {}

func _on_body_entered(_body):
	load_data(Autoload.slot)

	var current_scene_file = get_tree().current_scene.scene_file_path
	var next_level_number = current_scene_file.to_int() + 1
	
	Autoload.level = next_level_number
	save(Autoload.slot)

	var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"

	get_tree().change_scene_to_file(next_level_path)

func load_data(save_slot):
	if slot_exists(save_slot):
		var file_path = SAVE_PATH + str(save_slot) + ".save"
		var savefile = FileAccess.open(file_path, FileAccess.READ)
		game_data = savefile.get_var(true)

func save(save_slot):
	var file_path = SAVE_PATH + str(save_slot) + ".save"
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	
	game_data.level = Autoload.level

	file.store_var(game_data)
	file.close()

func slot_exists(save_slot):
	var file_path = SAVE_PATH + str(save_slot) + ".save"
	return FileAccess.file_exists(file_path)
