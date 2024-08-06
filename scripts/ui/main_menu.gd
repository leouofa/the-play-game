extends Control
func _ready():
	$VBoxContainer/StartButton.grab_focus()
	
func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")

func _on_level_button_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/levels.tscn")

func _on_quit_button_pressed():
	get_tree().quit()

func _on_continue_button_pressed():
	var level_path = "res://scenes/levels/level"+ str(Autoload.level) +".tscn"
	get_tree().change_scene_to_file(level_path)
