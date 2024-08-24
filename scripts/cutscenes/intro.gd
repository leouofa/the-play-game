extends Node2D

func _ready():
	Music.emit_signal("intro")

func _input(event):
	if event.is_action_pressed("ui_accept"):
		end_intro()

func end_intro():
	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")
