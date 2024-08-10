extends Node

@onready var player = $AudioStreamPlayer2D

signal change_level(level)
signal main_menu


func _on_change_level(level):
	print("Changing Level: " + str(level))

func _on_main_menu():
	print("Changing To Main Menu")
