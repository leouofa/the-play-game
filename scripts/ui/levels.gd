extends Control

func _on_level_1_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")


func _on_level_2_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level2.tscn")


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
