extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const GUN_COOLDOWN_TIMEOUT = 0.3

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var gun_equiped = true
var gun_cooldown = true
var bullet = preload("res://scenes/bullet.tscn")

@onready var animated_sprite = $AnimatedSprite2D
@onready var marker_2d = $Marker2D
@onready var animation_player = $AnimationPlayer

var bullet_direction = Vector2.RIGHT

func _physics_process(delta):
	apply_gravity(delta)
	handle_jump()
	handle_movement()
	update_animation()
	move_and_slide()
	handle_firing()

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

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

