extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	Autoload.death()
	timer.start()


func _on_timer_timeout():
	Autoload.check_and_do_level_reset()
	get_tree().reload_current_scene()
	Engine.time_scale = 1.0
