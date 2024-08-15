extends Area2D

const SPEED = 300
const DAMAGE = 100

var direction = Vector2.RIGHT

func _ready():
	pass

func _process(delta):
	position += (direction * SPEED) * delta

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func bullet_deal_damage():
	return DAMAGE

func remove_bullet():
	queue_free()
