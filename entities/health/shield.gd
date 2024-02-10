extends Area2D

class_name Shield
@export var max_health: int = 2

func _on_death():
	self.queue_free()

func _ready():
	$Health.max_health = max_health
	$Health.health = max_health
	$Health.connect("death", _on_death)
