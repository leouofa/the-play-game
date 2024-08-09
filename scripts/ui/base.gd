extends Control

const UI_SCENE_PATH = "res://scenes/ui/"

func goto_ui_scene(scene):
	var scene_file = UI_SCENE_PATH + scene + ".tscn"
	get_tree().change_scene_to_file(scene_file)
