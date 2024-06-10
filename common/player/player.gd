extends CharacterBody2D

signal shoot(pos: Vector2)

const SPEED = 300.0

var is_flipped = false

func _physics_process(delta):
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		is_flipped = false
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		is_flipped = true
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1

	if Input.is_action_just_pressed("shoot"):
		shoot.emit(get_viewport().get_mouse_position())
		
	velocity = velocity.normalized() * SPEED

	move_and_slide()
