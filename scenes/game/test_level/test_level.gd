extends Node2D

signal game_over

@onready var player = $Player
@onready var spawn_point = $SpawnPoint
@onready var timer = $Timer

var enemy_scene = preload("res://common/enemy/enemy.tscn")
var bullet_scene = preload("res://common/bullet/bullet.tscn")

func _ready():
	spawn_enemy()
	
	timer.timeout.connect(on_timeout)

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	
	enemy.target = player
	enemy.position = spawn_point.global_position
	
	enemy.add_to_group("Enemy")
	enemy.collide.connect(on_enemy_collide)
	
	player.shoot.connect(on_shoot)
	
	add_child(enemy)

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
	var collider = collision.get_collider()
	
	remove_child(bullet)
	
	if is_enemy(collider):
		remove_child(collider)

func on_enemy_collide(enemy: CharacterBody2D, collision: KinematicCollision2D):
	var collider = collision.get_collider()
	
	if collider == player:
		game_over.emit()

func is_enemy(collider: Object):
	return collider.is_in_group("Enemy")

func on_timeout():
	spawn_enemy()
