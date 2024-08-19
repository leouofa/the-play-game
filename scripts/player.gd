extends CharacterBody2D

var SPEED = 130.0
var REGULAR_SPEED = 130
var DASH_SPEED = 300

const BASE_JUMP_VELOCITY = -300.0
const GUN_COOLDOWN_TIMEOUT = 0.3

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var current_timescale = 1.0

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


@onready var damage_timer = $DamageTimer

# Hud Timers
@onready var dash_timer = $DashTimer
@onready var slow_timer = $SlowTimer



var bullet_direction = Vector2.RIGHT

var dash_gravity_direction = Vector3(-98, 0, 0)
var	dashing_gravity_x_pos = -3

var jump_count = 0
const MAX_JUMPS = 2

func _physics_process(delta):
	apply_gravity(delta)
	handle_jump()
	handle_dash()
	handle_slow()
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

func handle_slow():
	var new_timescale = 1.0

	if Input.is_action_pressed("slow") and Autoload.slow > 0:
		new_timescale = 0.5

		if slow_timer.is_stopped():
			slow_timer.start(0.10)
	elif not Input.is_action_pressed("slow"):

		if not slow_timer.is_stopped():
			slow_timer.stop()

		Autoload.slow = min(Autoload.slow + 1, Autoload.MAX_SLOW)

	if current_timescale != new_timescale:
		current_timescale = new_timescale
		Engine.time_scale = current_timescale

func handle_dash():
	SPEED = REGULAR_SPEED

	if Input.is_action_pressed("dash") and Autoload.dash > 0:
		SPEED = DASH_SPEED

		if dash_timer.is_stopped():
			dash_timer.start(0.10)

		dashing_player.play("RESET")
		dashing_player.play("dash")
		dashing_timer.start()

	elif not Input.is_action_pressed("dash"):
		SPEED = REGULAR_SPEED

		if not dash_timer.is_stopped():
			dash_timer.stop()  # Stop the timer when dash is not pressed

		Autoload.dash = min(Autoload.dash + 1, Autoload.MAX_DASH)

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

func _on_dash_timer_timeout():
	Autoload.dash -= 1

	if Autoload.dash <= 0:
		dash_timer.stop()
		Autoload.dash = 0

func _on_slow_timer_timeout():
	Autoload.slow -= 1

	if Autoload.slow <= 0:
		dash_timer.stop()
		Autoload.slow = 0

func show_damage():
	var flash_color = Color(1.0, 1.0, 1.0)
	animated_sprite.material.set_shader_parameter("flash_color", flash_color)
	animated_sprite.material.set_shader_parameter("flash_modifier", 0.8)

	damage_timer.start()

func _on_damage_timer_timeout():
	animated_sprite.material.set_shader_parameter("flash_modifier", 0)
	damage_timer.stop()

