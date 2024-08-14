extends Node2D

var SPEED = 60
var health = 200
var dead = false

var direction = 1

@onready var animated_sprite = $AnimatedSprite2D
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var killzone = $Killzone

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
		
	position.x += direction * SPEED * delta


func _on_hitbox_area_entered(area):
	if area.has_method("bullet_deal_damage"):
		var damage = area.bullet_deal_damage()
		take_damage(damage)

func take_damage(damage):
	health = health - damage

	if health <= 0 and !dead:
		death()

func death():
	dead = true
	SPEED = 0
	animated_sprite.play("death")
	killzone.queue_free()
	await get_tree().create_timer(1).timeout

	
		

		
