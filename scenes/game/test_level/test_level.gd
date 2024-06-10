extends Node2D

@onready var player = $Player

var bullet_scene = preload("res://common/bullet/bullet.tscn")

func _ready():
	player.shoot.connect(on_shoot)

func on_shoot(target: Vector2):
	var bullet = bullet_scene.instantiate()
	
	bullet.target = get_global_mouse_position()
	bullet.position = player.get_gun_pos()
	bullet.speed = 400
	
	bullet.reach_target.connect(on_reach_target)
	bullet.hit_target.connect(on_hit_target)
	
	add_child(bullet)

func on_reach_target(bullet: CharacterBody2D):
	remove_child(bullet)

func on_hit_target(bullet: CharacterBody2D, collision: KinematicCollision2D):
	remove_child(bullet)
