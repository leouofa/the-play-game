extends "res://scripts/ui/base.gd"

@onready var back_button = $VBoxContainer3/BackButton

@onready var	slot1 = $VBoxContainer/SlotOne
@onready var	slot2 = $VBoxContainer/SlotTwo
@onready var	slot3 = $VBoxContainer/SlotThree

var files = {}

func _ready():
	back_button.grab_focus()

	for i in range(1, 4):  # range(start, end) where end is exclusive
		if slot_exists(i):
			load_data(i)
			files[i] = game_data
	
	var sorted_scores = get_sorted_usernames_by_score(files)

	for i in range(1, 4):  # range(start, end) where end is exclusive
		var slot_name = "slot" + str(i)
		var slot_variable = get(slot_name)

		if (i - 1) < sorted_scores.size():
			slot_variable.set_text(sorted_scores[i-1][0] + " - " + str(sorted_scores[i-1][1]))
		else:
			slot_variable.set_text("Empty")
			slot_variable.visible = false
	
func _on_back_button_pressed():
	goto_ui_scene("main_menu")
	
# Function to calculate total scores and return sorted list
func get_sorted_usernames_by_score(data):
	var totals = {}
	
	# Calculate total scores for each user
	for user_id in data.keys():
		var user = data[user_id]
		var total_score = 0
		for score in user["scores"].values():
			total_score += score
		totals[user["username"]] = total_score
	
	# Convert dictionary to array of tuples and sort
	var sorted_totals = []
	for username in totals.keys():
		sorted_totals.append([username, totals[username]])
	
	sorted_totals.sort_custom(_sort_by_score) # Sort in descending order
	
	return sorted_totals

# Helper function to sort by score in descending order
func _sort_by_score(a, b):
	if a[1] > b[1]:
		return true
	return false
