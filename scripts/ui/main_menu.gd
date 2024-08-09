extends "res://scripts/ui/base.gd"

func _ready():
	$VBoxContainer/StartButton.grab_focus()
	
func _on_start_button_pressed():
	goto_ui_scene("new_game")

func _on_level_button_pressed():
	goto_ui_scene("levels")

func _on_continue_button_pressed():
	goto_ui_scene("continue_game")

func _on_high_score_button_pressed():
	goto_ui_scene("high_scores")

func _on_quit_button_pressed():
	get_tree().quit()
