extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	print("You died!")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	Autoload.lives -= 1
	timer.start()


func _on_timer_timeout():
	if Autoload.lives == 0:
		Autoload.lives = 3
		Autoload.score = 0
	get_tree().reload_current_scene()
	Engine.time_scale = 1.0
