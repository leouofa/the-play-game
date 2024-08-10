extends Node

const MUSIC_PATH = "res://assets/music/"

@onready var player = $AudioStreamPlayer2D

var new_stream: AudioStream

signal change_level(level)
signal main_menu



func _on_change_level(level):
	new_stream = load(MUSIC_PATH + "level" + str(level) +".mp3")
	player.stream = new_stream
	player.play()

func _on_main_menu():
	new_stream = preload(MUSIC_PATH + "time_for_adventure.mp3")
	player.stream = new_stream
	player.play()
