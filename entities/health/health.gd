extends Node
class_name Health

signal death
signal damage

@export var team: ProjectileBase.Team
@export var max_health: int = 1
var health: int = 0

func _ready():
	health = max_health

func deal_damage(val: int):
	health -= val
	if health <= 0:
		emit_signal("death")
	else:
		emit_signal("damage")
