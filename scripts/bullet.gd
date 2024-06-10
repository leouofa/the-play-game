extends Area2D

const SPEED = 300
var direction = Vector2.RIGHT

func _ready():
	pass

func _process(delta):
	position += (direction * SPEED) * delta

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
