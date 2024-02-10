extends Node
class_name Health

signal death

@export var team: ProjectileBase.TEAM
@export var max_health: int = 1
var health: int = 0

func _ready():
	health = max_health

func deal_damage(val: int):
	health -= val
	if health <= 0:
		emit_signal("death")
