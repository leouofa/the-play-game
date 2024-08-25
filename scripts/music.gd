extends Node

const MUSIC_PATH = "res://assets/music/"

@onready var player = $AudioStreamPlayer2D
var new_stream: AudioStream
var last_level: int = -1  # Initialize to a value that cannot be a valid level

signal change_level(level)
signal intro
signal main_menu

func _on_change_level(level):
	if level != last_level:
		play_file("level" + str(level))
		last_level = level  # Update the last level to the current level


func _on_intro():
	play_file("intro")

func _on_main_menu():
	play_file("time_for_adventure")
	
func play_file(file):
	new_stream = load(MUSIC_PATH + str(file) +".mp3")
	player.stream = new_stream
	player.stream.loop = true
	player.play()
