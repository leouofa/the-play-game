extends Control

const SAVE_PATH = "user://save_slot_"


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")


func _on_slot_one_pressed():
	save(1)


func _on_slot_two_pressed():
	pass # Replace with function body.


func _on_slot_three_pressed():
	pass # Replace with function body.

func save(save_slot):
	var file = FileAccess.open(SAVE_PATH + str(save_slot) + ".save", FileAccess.WRITE)
	var variable1 = 0
	file.store_var(variable1)

		
