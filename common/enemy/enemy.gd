extends CharacterBody2D

signal collide(enemy: CharacterBody2D, collision: KinematicCollision2D)

@export var speed: float = 30.0
@export var target: CharacterBody2D
@export var damage: float = 10
@export var max_health: float = 100:
	set(h):
		health = h
		max_health = h

@onready var health_bar = $HealthBar

var health = 100:
	set(h):
		health = h
		$HealthBar.health = h

func _physics_process(delta):
	if is_dead():
		return
	
	var collision = move_and_collide((target.position - position).normalized() * delta * speed)

	if !!collision:
		collide.emit(self, collision)
		
	health_bar.visible = health < max_health

func is_dead():
	return health <= 0

func take_damage(damage: float):
	health -= damage

func get_attack_damage():
	return damage
