class_name BadGuy

extends Node2D

@export var PLAYER_DAMAGE = 25
@export var SPEED = 60
@export var HEALTH = 200

@export var default_flash_color = Color(1, 1, 1, 1)
@export_range(0.0, 1.0) var default_flash_modifier = 0.0

var dead = false

var direction = 1

@onready var animated_sprite = $AnimatedSprite2D
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var killzone = $Killzone
@onready var hitbox = $hitbox
@onready var flash_timer = $FlashTimer

var next_level = preload("res://scenes/next_level.tscn")

func _ready():
	animated_sprite.material.set_shader_parameter("flash_color", default_flash_color)
	animated_sprite.material.set_shader_parameter("flash_modifier", default_flash_modifier)

func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
		
	position.x += direction * SPEED * delta


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
	post_death()

func post_death():
	print("initial_post_death")