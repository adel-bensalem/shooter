extends CharacterBody2D

signal collide(enemy: CharacterBody2D, collision: KinematicCollision2D)

@export var speed = 30.0
@export var target: CharacterBody2D


func _physics_process(delta):
	var collision = move_and_collide((target.position - position).normalized() * delta * speed)

	if !!collision:
		collide.emit(self, collision)
