extends Node2D

@export var health: float:
	set(h):
		$ProgressBar.value = h
		health = h
@export var max_health: float:
	set(th):
		$ProgressBar.max_value = th
		max_health = th
