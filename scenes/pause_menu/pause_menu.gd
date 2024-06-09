extends CanvasLayer

signal resume
signal open_options
signal save
signal exit

@onready var resume_button = $Menu/Actions/ResumeButton
@onready var save_button = $Menu/Actions/SaveButton
@onready var options_button = $Menu/Actions/OptionsButton
@onready var exit_button = $Menu/Actions/ExitButton

func _ready():
	resume_button.pressed.connect(on_resume)
	save_button.pressed.connect(on_save)
	options_button.pressed.connect(on_open_options)
	exit_button.pressed.connect(on_exit)

func on_save():
	save.emit()

func on_resume():
	resume.emit()

func on_open_options():
	open_options.emit()

func on_exit():
	exit.emit()
