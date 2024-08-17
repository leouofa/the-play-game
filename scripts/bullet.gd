extends Area2D

const SPEED = 400
const DAMAGE = 100
@onready var animation_player = $AnimationPlayer
@onready var particles = $GPUParticles2D

var direction = Vector2.RIGHT
var hit = preload("res://scenes/hit.tscn")

@onready var marker_2d = $Marker2D

func _ready():
	animation_player.play("pulse")

	if direction == Vector2.LEFT:
		particles.process_material.set("gravity", Vector3(-400, 0, 0))
	else:
		particles.process_material.set("gravity", Vector3(400, 0, 0))

func _process(delta):
	position += (direction * SPEED) * delta

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func bullet_deal_damage():
	return DAMAGE

func remove_bullet():
	queue_free()

func _on_area_entered(area):
	print("collided with bullet")
	print(area)
	var hit_instance = hit.instantiate()
	get_parent().add_child(hit_instance)
	hit_instance.global_position = marker_2d.global_position
