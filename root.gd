extends Node2D

enum GameModes {
	MainMenu,
	Game,
	GameOver,
}

@onready var save_file = $SaveFile

var current_game_mode = GameModes.MainMenu
var main_menu = preload("res://scenes/main_menu/main_menu.tscn")
var game = preload("res://scenes/game/game.tscn")
var pause_menu = preload("res://scenes/pause_menu/pause_menu.tscn")
var options_menu = preload("res://scenes/options_menu/options_menu.tscn")
var game_over = preload("res://scenes/game_over/game_over.tscn")
var target = preload("res://target.png")
var current_game = null

func _ready():
	save_file.load_save()
	start_main_menu()

func _unhandled_key_input(event):
	if current_game_mode == GameModes.Game:
		if event.is_action_pressed("pause"):
			if !get_tree().paused:
				pause()
			else:
				un_pause()

func start_main_menu():
	for child in get_children():
		remove_child(child)
	
	current_game = main_menu.instantiate()
	current_game_mode = GameModes.MainMenu
	
	add_child(current_game)
	reset_cursor()
	
	current_game.start.connect(start_game)
	current_game.open_options.connect(open_options)
	current_game.exit.connect(exit_game)

func start_game():
	for child in get_children():
		remove_child(child)
	
	current_game = game.instantiate()
	current_game_mode = GameModes.Game
	
	current_game.game_over.connect(on_game_over)
	
	add_child(current_game)
	replace_cursor_with_target()

func pause():
	var pm = pause_menu.instantiate()
	
	add_child(pm)
	reset_cursor()
	get_tree().paused = true
	
	pm.resume.connect(un_pause)
	pm.open_options.connect(open_options)
	pm.save.connect(save_game)
	pm.exit.connect(exit_game)

func un_pause():
	var pm = get_node("PauseMenu")
	
	if !!pm:
		remove_child(pm)
	
	replace_cursor_with_target()
	get_tree().paused = false

func open_options():
	var options = options_menu.instantiate()
	
	options.volume = save_file.get_save_data("volume", 100)

	options.save.connect(save_options)
	options.exit.connect(exit_options)
	
	add_child(options)
	reset_cursor()

func save_options():
	var options = get_node("OptionsMenu")
	
	if !!options:
		save_file.save({ "volume": options.volume })
		remove_child(options)

func exit_options():
	var options = get_node("OptionsMenu")
	
	if !!options:
		remove_child(options)

func save_game():
	pass

func exit_game():
	get_tree().quit()

func replace_cursor_with_target():
	Input.set_custom_mouse_cursor(target)

func reset_cursor():
	Input.set_custom_mouse_cursor(null)

func on_game_over():
	for child in get_children():
		remove_child(child)
	
	current_game = game_over.instantiate()
	current_game_mode = GameModes.GameOver
	
	current_game.retry.connect(start_game)
	current_game.open_main_menu.connect(start_main_menu)
	current_game.exit.connect(exit_game)
	
	add_child(current_game)
	reset_cursor()
