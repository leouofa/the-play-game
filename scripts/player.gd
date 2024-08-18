extends CharacterBody2D

var SPEED = 130.0
var REGULAR_SPEED = 130
var DASH_SPEED = 200

const BASE_JUMP_VELOCITY = -300.0  # Changed from JUMP_VELOCITY to BASE_JUMP_VELOCITY
const GUN_COOLDOWN_TIMEOUT = 0.3

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var gun_equiped = true
var gun_cooldown = true
var bullet = preload("res://scenes/bullet.tscn")

@onready var animated_sprite = $AnimatedSprite2D
@onready var marker_2d = $Marker2D
@onready var animation_player = $AnimationPlayer

var bullet_direction = Vector2.RIGHT

var jump_count = 0
const MAX_JUMPS = 2

func _physics_process(delta):
	apply_gravity(delta)
	handle_jump()
	handle_dash()
	handle_movement()
	update_animation()
	move_and_slide()
	handle_firing()
	reset_jump_count()

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_jump():
	if Input.is_action_just_pressed("jump") and jump_count < MAX_JUMPS:
		var jump_velocity = BASE_JUMP_VELOCITY / pow(1.2, jump_count)
		velocity.y = jump_velocity
		jump_count += 1

func reset_jump_count():
	if is_on_floor():
		jump_count = 0

func handle_dash():
	if Input.is_action_pressed("dash"):
		SPEED = DASH_SPEED
	else:
		SPEED = REGULAR_SPEED

func handle_movement():
	var input_direction = Input.get_axis("move_left", "move_right")
	update_direction(input_direction)
	velocity.x = input_direction * SPEED if input_direction != 0 else move_toward(velocity.x, 0, SPEED)

func update_direction(input_direction):
	if input_direction > 0:
		bullet_direction = Vector2.RIGHT
		animated_sprite.flip_h = false
		marker_2d.position.x = abs(marker_2d.position.x)
	elif input_direction < 0:
		bullet_direction = Vector2.LEFT
		animated_sprite.flip_h = true
		marker_2d.position.x = -abs(marker_2d.position.x)

func update_animation():
	if is_on_floor():
		if velocity.x == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")

func handle_firing():
	if Input.is_action_just_pressed("fire") and gun_equiped and gun_cooldown:
		gun_cooldown = false
		var bullet_instance = bullet.instantiate()
		bullet_instance.direction = bullet_direction
		get_parent().add_child(bullet_instance)
		bullet_instance.global_position = marker_2d.global_position
		
		animation_player.play("RESET")
		animation_player.play("shot")

		await get_tree().create_timer(GUN_COOLDOWN_TIMEOUT).timeout
		gun_cooldown = true
