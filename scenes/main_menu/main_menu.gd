extends CanvasLayer

signal start
signal open_options
signal exit

@onready var start_button = $Menu/Actions/StartButton
@onready var options_button = $Menu/Actions/OptionsButton
@onready var exit_button = $Menu/Actions/ExitButton

func _ready():
	start_button.pressed.connect(on_start)
	options_button.pressed.connect(on_open_options)
	exit_button.pressed.connect(on_exit)

func on_start():
	start.emit()

func on_open_options():
	open_options.emit()

func on_exit():
	exit.emit()
