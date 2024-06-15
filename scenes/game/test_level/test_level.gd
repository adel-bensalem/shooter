extends Node2D

signal game_over

@onready var player = $Player
@onready var spawn_point = $SpawnPoint
@onready var spawn_timer = $SpawnTimer
@onready var invincibility_timer = $InvincibilityTimer
@onready var hud = $HUD

var enemy_scene = preload("res://common/enemy/enemy.tscn")
var bullet_scene = preload("res://common/bullet/bullet.tscn")

var player_health = 100:
	set(h):
		player_health = h
		$HUD.health = h
var is_player_invincible = false

func _ready():
	spawn_enemy()
	
	spawn_timer.timeout.connect(on_spawn_timeout)
	invincibility_timer.timeout.connect(on_invincibility_timeout)

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
		collider.take_damage(bullet.get_attack_damage())
		
		if collider.is_dead():
			remove_child(collider)

func on_enemy_collide(enemy: CharacterBody2D, collision: KinematicCollision2D):
	var collider = collision.get_collider()
	
	if collider == player && can_player_take_damage():
		take_player_damage(enemy.get_attack_damage())
		
		if is_player_dead():
			game_over.emit()
		else:
			make_player_invincible()

func is_enemy(collider: Object):
	return collider.is_in_group("Enemy")

func on_spawn_timeout():
	spawn_enemy()

func on_invincibility_timeout():
	is_player_invincible = false

func is_player_dead():
	return player_health <= 0

func can_player_take_damage():
	return !is_player_invincible

func take_player_damage(damage: float):
	player_health -= damage

func make_player_invincible():
	is_player_invincible = true
	invincibility_timer.start()
