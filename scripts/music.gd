extends Node

const MUSIC_PATH = "res://assets/music/"

@onready var player = $AudioStreamPlayer2D
var new_stream: AudioStream

signal change_level(level)
signal main_menu

func _on_change_level(level):
	play_file("level" + str(level))

func _on_main_menu():
	play_file("time_for_adventure")
	
func play_file(file):
	new_stream = load(MUSIC_PATH + str(file) +".mp3")
	player.stream = new_stream
	player.play()
