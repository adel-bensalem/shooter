extends Node2D

signal game_over

@onready var test_level = $TestLevel

func _ready():
	test_level.game_over.connect(on_game_over)

func on_game_over():
	game_over.emit()
