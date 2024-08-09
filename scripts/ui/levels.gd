extends "res://scripts/ui/base.gd"

func _on_level_1_button_pressed():
	goto_level('1')

func _on_level_2_button_pressed():
	goto_level('2')

func _on_back_button_pressed():
	goto_ui_scene("main_menu")
