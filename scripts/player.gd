extends CharacterBody2D

var SPEED = 130.0
var REGULAR_SPEED = 130
var DASH_SPEED = 200

const BASE_JUMP_VELOCITY = -300.0
const GUN_COOLDOWN_TIMEOUT = 0.3

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var gun_equiped = true
var gun_cooldown = true
var bullet = preload("res://scenes/bullet.tscn")

@onready var animated_sprite = $AnimatedSprite2D
@onready var marker_2d = $Marker2D
@onready var shot_player = $ShotPlayer

@onready var jump_player = $JumpPlayer
@onready var jump_timer = $JumpPlayer/JumpTimer

@onready var double_jump_player = $DoubleJumpPlayer
@onready var double_jump_timer = $DoubleJumpPlayer/DoubleJumpTimer

@onready var dashing_player = $DashingPlayer
@onready var dashing_timer = $DashingPlayer/DashingTimer
@onready var dashing_particles = $DashingParticles


var bullet_direction = Vector2.RIGHT

var dash_gravity_direction = Vector3(-98, 0, 0)
var	dashing_gravity_x_pos = -3

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

		if jump_count == 0:
			jump_player.play("RESET")
			jump_player.play("jump")
			jump_timer.start() 

		elif jump_count > 0 :
			double_jump_player.play("RESET")
			double_jump_player.play("double_jump")
			double_jump_timer.start()
			
			var flash_color = Color(217 / 255.0, 99 / 255.0, 0 / 255.0)
			animated_sprite.material.set_shader_parameter("flash_color", flash_color)
			animated_sprite.material.set_shader_parameter("flash_modifier", 0.02)


		jump_count += 1


func reset_jump_count():
	if is_on_floor():
		jump_count = 0

func handle_dash():
	if Input.is_action_pressed("dash"):
		SPEED = DASH_SPEED

		dashing_player.play("RESET")
		dashing_player.play("dash")
		dashing_timer.start()

	else:
		SPEED = REGULAR_SPEED

func handle_movement():
	var input_direction = Input.get_axis("move_left", "move_right")
	update_direction(input_direction)
	velocity.x = input_direction * SPEED if input_direction != 0 else move_toward(velocity.x, 0, SPEED)

func update_direction(input_direction):
	if input_direction > 0:
		bullet_direction = Vector2.RIGHT
		dash_gravity_direction = Vector3(-98, 0, 0)
		dashing_gravity_x_pos = -3
		animated_sprite.flip_h = false
		marker_2d.position.x = abs(marker_2d.position.x)
	elif input_direction < 0:
		bullet_direction = Vector2.LEFT
		dash_gravity_direction = Vector3(98, 0, 0)
		dashing_gravity_x_pos = 3
		animated_sprite.flip_h = true
		marker_2d.position.x = -abs(marker_2d.position.x)

	dashing_particles.process_material.set("gravity", dash_gravity_direction)
	dashing_particles.position = Vector2(dashing_gravity_x_pos, dashing_particles.position.y)

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
		
		shot_player.play("RESET")
		shot_player.play("shot")

		await get_tree().create_timer(GUN_COOLDOWN_TIMEOUT).timeout
		gun_cooldown = true


func _on_jump_timer_timeout():
	jump_player.play("RESET")


func _on_double_jump_timer_timeout():
	animated_sprite.material.set_shader_parameter("flash_modifier", 0)
	double_jump_player.play("RESET")


func _on_dashing_timer_timeout():
	dashing_player.play("RESET")
