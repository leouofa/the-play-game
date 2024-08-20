extends Area2D

const FILE_BEGIN = "res://scenes/levels/level"
const SAVE_PATH = "user://save_slot_"

var game_data = {}
@onready var canvas_layer = $CanvasLayer
@onready var animation_player = $AnimationPlayer


func _ready():
	canvas_layer.show()
	animation_player.play("transition_out")
	await animation_player.animation_finished


func _on_body_entered(_body):
	load_data(Autoload.slot)

	var current_scene_file = get_tree().current_scene.scene_file_path
	var next_level_number = current_scene_file.to_int() + 1
	
	Autoload.level = next_level_number
	save(Autoload.slot)

	var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"

	Autoload.score = 0

	animation_player.play("transition_in")
	await animation_player.animation_finished

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
	game_data["scores"][str(Autoload.level - 1)] = calculate_score()

	file.store_var(game_data)
	file.close()

	print(game_data)

func calculate_score():
	var score = float(Autoload.score) / Autoload.time * 100
	return score

func slot_exists(save_slot):
	var file_path = SAVE_PATH + str(save_slot) + ".save"
	return FileAccess.file_exists(file_path)
