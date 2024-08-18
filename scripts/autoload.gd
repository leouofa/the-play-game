extends Node

var slot : int = 1

var score : int = 0
var time	: int = 0
var lives : int = 3
var health :	int = 100
var dash :	int = 200

var level : = 1

const MAX_HEALTH = 100
const MAX_DASH = 200

@onready var timer = $Timer

func take_damage(body, damage):
	var new_health = health - damage
	health = new_health

	if health <= 0:
		death(body)


func death(body, fast=false):
	lives -= 1

	if fast:
		Engine.time_scale = 1.0
	else:
		Engine.time_scale = 0.5

	body.get_node("CollisionShape2D").queue_free()

	timer.start()

func check_and_do_level_reset():
	if lives <= 0:
		lives = 3
		score = 0

func _on_timer_timeout():
	check_and_do_level_reset()
	get_tree().reload_current_scene()
	health = MAX_HEALTH
	dash = MAX_DASH
	Engine.time_scale = 1.0
