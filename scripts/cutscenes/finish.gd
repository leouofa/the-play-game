extends Node2D

const SAVE_PATH = "user://save_slot_"
var game_data = {}
var save_slot = Autoload.slot
@onready var high_score: Label = $"HBoxContainer/High Score"


func _ready():
	Music.play_ending()
	load_data()
	high_score.set_text("Score: " + str(calculate_total_score()))

func _input(event):
	if event.is_action_pressed("ui_accept"):
		end_intro()

func end_intro():
	Music.play_main_menu()
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")

func load_data():
	if slot_exists():
		var file_path = SAVE_PATH + str(save_slot) + ".save"
		var savefile = FileAccess.open(file_path, FileAccess.READ)
		game_data = savefile.get_var(true)

func slot_exists():
	var file_path = SAVE_PATH + str(save_slot) + ".save"
	return FileAccess.file_exists(file_path)

func calculate_total_score():
	if "scores" in game_data:
		var total_score = 0.0
		for score in game_data["scores"].values():
			total_score += score
		return ceil(total_score)
	else:
		return 0
