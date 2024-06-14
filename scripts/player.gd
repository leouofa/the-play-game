extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const GUN_COOLDOWN_TIMEOUT = 0.4

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var gun_equiped = true
var gun_cooldown = true
var bullet = preload("res://scenes/bullet.tscn")

@onready var animated_sprite = $AnimatedSprite2D
@onready var marker_2d = $Marker2D

var bullet_direction = Vector2.RIGHT # Default bullet direction is right

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# gets input direction: -1, 0, 1
	var input_direction = Input.get_axis("move_left", "move_right")
	
	# update bullet direction based on input
	if input_direction > 0:
		bullet_direction = Vector2.RIGHT
		animated_sprite.flip_h = false
		marker_2d.position.x = abs(marker_2d.position.x)  # Ensure marker is on the right side
	elif input_direction < 0:
		bullet_direction = Vector2.LEFT
		animated_sprite.flip_h = true
		marker_2d.position.x = -abs(marker_2d.position.x)  # Ensure marker is on the left side
	
	# play animation	
	if is_on_floor():
		if input_direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else: 
		animated_sprite.play("jump")
		
	# update velocity based on input
	if input_direction != 0:
		velocity.x = input_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# handle firing
	if Input.is_action_just_pressed("fire") and gun_equiped and gun_cooldown:
		gun_cooldown = false
		var bullet_instance = bullet.instantiate()

		if bullet_direction == Vector2.LEFT:
			bullet_instance.direction = Vector2.LEFT

		get_parent().add_child(bullet_instance)
		bullet_instance.global_position = marker_2d.global_position

		await get_tree().create_timer(GUN_COOLDOWN_TIMEOUT).timeout
		gun_cooldown = true

