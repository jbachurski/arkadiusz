extends Node
class_name Health

signal death
signal damage

@export var team: ProjectileBase.Team
@export var max_health: int = 1
var health: int = 0
var stop_its_already_dead: bool = false

func _ready():
	health = max_health

func is_immune(proj_team: ProjectileBase.Team):
	if has_node("Invframe"):
		var inv = find_child("Invframe")
		if not inv.vulnerable():
			return true
	return team == proj_team

func deal_damage(val: int, proj_team: ProjectileBase.Team) -> bool:
	if is_immune(proj_team) or stop_its_already_dead:
		return false
	if has_node("Invframe"):
		var inv = find_child("Invframe")
		inv.reset_iframes()
	health -= val
	if health <= 0:
		stop_its_already_dead = true
		emit_signal("death")
	else:
		emit_signal("damage")
	return true
