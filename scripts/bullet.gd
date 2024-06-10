extends Area2D

const SPEED = 300

func _ready():
	pass

func _process(delta):
	position += (Vector2.RIGHT * SPEED) * delta

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
