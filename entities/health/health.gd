extends Node
class_name Health

signal death
signal damage

@export var team: ProjectileBase.Team
@export var max_health: int = 1
var health: int = 0

func _ready():
	health = max_health
	print(get_parent(), " my team is ", team)

func is_immune(proj_team: ProjectileBase.Team):
	return team == proj_team

func deal_damage(val: int, proj_team: ProjectileBase.Team) -> bool:
	if is_immune(proj_team):
		return false
	print(team, " took damage from ", proj_team)
	health -= val
	if health <= 0:
		emit_signal("death")
	else:
		emit_signal("damage")
	return true
