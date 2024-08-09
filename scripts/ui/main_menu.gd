extends Control

const SCENE_PATH = "res://scenes/ui/"

func _ready():
	$VBoxContainer/StartButton.grab_focus()
	
func _on_start_button_pressed():
	goto_scene("new_game")

func _on_level_button_pressed():
	goto_scene("levels")

func _on_continue_button_pressed():
	goto_scene("continue_game")

func _on_high_score_button_pressed():
	goto_scene("high_scores")

func _on_quit_button_pressed():
	get_tree().quit()

func goto_scene(scene):
	var scene_file = SCENE_PATH + scene + ".tscn"
	get_tree().change_scene_to_file(scene_file)

