extends CanvasLayer

@export var health: float:
	set(h):
		$HealthBar.value = h
		health = h
@export var max_health: float:
	set(th):
		$HealthBar.max_value = th
		max_health = th

