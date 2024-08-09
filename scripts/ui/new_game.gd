extends "res://scripts/ui/base.gd"

@onready var slot1 = $VBoxContainer/SlotOne
@onready var slot2 = $VBoxContainer/SlotTwo
@onready var slot3 = $VBoxContainer/SlotThree

func _ready():
	slot1.grab_focus()

	for i in range(1, 4):  # range(start, end) where end is exclusive
		var slot_name = "slot" + str(i)
		var slot_variable = get(slot_name)

		if slot_exists(i):
			load_data(i)
			slot_variable.set_text(game_data.username)
		else:
			slot_variable.set_text("Empty")

func _on_back_button_pressed():
	goto_ui_scene("main_menu")

func _on_slot_one_pressed():
	Autoload.slot = 1
	goto_name_scene()

func _on_slot_two_pressed():
	Autoload.slot = 2
	goto_name_scene()

func _on_slot_three_pressed():
	Autoload.slot = 3
	goto_name_scene()

func goto_name_scene():
	goto_ui_scene("player_name")
