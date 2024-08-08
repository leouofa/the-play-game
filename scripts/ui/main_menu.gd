extends Control
func _ready():
	$VBoxContainer/StartButton.grab_focus()
	
func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/new_game.tscn")

func _on_level_button_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/levels.tscn")

func _on_quit_button_pressed():
	get_tree().quit()

func _on_continue_button_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/continue_game.tscn")
