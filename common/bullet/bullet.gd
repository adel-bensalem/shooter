extends CharacterBody2D

signal reach_target(bullet: CharacterBody2D)
signal hit_target(bullet: CharacterBody2D, collision: KinematicCollision2D)

@export var speed: int = 100
@export var target: Vector2 = Vector2.ZERO

var initial_position = Vector2.ZERO

func _ready():
	initial_position = position

func _physics_process(delta):
	var collision = move_and_collide((target - position).normalized() * delta * speed)
	
	if has_reached_target():
		reach_target.emit(self)
	
	if !!collision:
		hit_target.emit(self, collision)

func has_reached_target():
	var direction = initial_position - target
	var has_gone_beyond_x = (target.x <= position.x) if direction.x < 0 else (target.x >= position.x)
	var has_gone_beyond_y = (target.y <= position.y) if direction.y < 0 else (target.y >= position.y)
	
	return has_gone_beyond_x && has_gone_beyond_y
