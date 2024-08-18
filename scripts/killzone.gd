extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	Engine.time_scale = 0.5
	Autoload.death(body)
	timer.start()


func _on_timer_timeout():
	Autoload.check_and_do_level_reset()
	get_tree().reload_current_scene()
	Engine.time_scale = 1.0
