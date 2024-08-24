extends Node2D

func _ready():
	Music.emit_signal("intro")

func end_intro():
	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")
