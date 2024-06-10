extends CanvasLayer

signal retry
signal open_main_menu
signal exit

@onready var retry_button = $Menu/Actions/RetryButton
@onready var main_menu_button = $Menu/Actions/MainMenuButton
@onready var exit_button = $Menu/Actions/ExitButton

func _ready():
	retry_button.pressed.connect(on_retry)
	main_menu_button.pressed.connect(on_open_main_menu)
	exit_button.pressed.connect(on_exit)


func on_retry():
	retry.emit()

func on_open_main_menu():
	open_main_menu.emit()
	
func on_exit():
	exit.emit()
