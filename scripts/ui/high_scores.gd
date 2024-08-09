extends "res://scripts/ui/base.gd"

@onready var back_button = $VBoxContainer3/BackButton

var files = {}

func _ready():
	back_button.grab_focus()

	for i in range(1, 4):  # range(start, end) where end is exclusive
		if slot_exists(i):
			load_data(i)
			files[i] = game_data
	
	var sorted_scores = get_sorted_usernames_by_score(files)
	
	for entry in sorted_scores:
		print("Username: %s, Total Score: %d" % [entry[0], entry[1]])

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
	return b[1] - a[1]
