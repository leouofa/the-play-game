extends Control

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")

func _on_level_button_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/levels.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
