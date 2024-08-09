extends "res://scripts/ui/base.gd"

@onready var	slot1 = $VBoxContainer/SlotOne
@onready var	slot2 = $VBoxContainer/SlotTwo
@onready var	slot3 = $VBoxContainer/SlotThree

var focused = false

func _ready():
	for i in range(1, 4):  # range(start, end) where end is exclusive
		var slot_name = "slot" + str(i)
		var slot_variable = get(slot_name)

		if slot_exists(i):
			load_data(i)
			slot_variable.set_text(game_data.username)
			if focused == false:
				slot_variable.grab_focus()
				focused = true
				
		else:
			slot_variable.disabled = true


func _on_back_button_pressed():
	goto_ui_scene("main_menu")

func _on_slot_one_pressed():
	change_level(1)

func _on_slot_two_pressed():
	change_level(2)

func _on_slot_three_pressed():
	change_level(3)

func change_level(slot):
	Autoload.slot = slot
	load_data(slot)
	goto_level(str(game_data.level))
