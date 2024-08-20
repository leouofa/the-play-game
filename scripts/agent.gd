extends Node2D

@export var PLAYER_DAMAGE = 25
@export var SPEED = 60
@export var HEALTH = 200

var dead = false

var direction = 1

@onready var animated_sprite = $AnimatedSprite2D
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var killzone = $Killzone
@onready var hitbox = $hitbox
@onready var flash_timer = $FlashTimer

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
		area.remove_bullet()

func take_damage(damage):
	HEALTH = HEALTH - damage

	if !dead:
		flash()

	if HEALTH <= 0 and !dead:
		death()

func flash():
	animated_sprite.material.set_shader_parameter("flash_modifier", 1)
	flash_timer.start()

func death():
	dead = true
	SPEED = 0
	animated_sprite.play("death")
	killzone.queue_free()
	hitbox.queue_free()

func _on_flash_timer_timeout():
	animated_sprite.material.set_shader_parameter("flash_modifier", 0)

func _on_killzone_body_entered(body):
	Autoload.take_damage(body, PLAYER_DAMAGE)
