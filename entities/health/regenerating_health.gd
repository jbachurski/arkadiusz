extends Health
class_name RegeneratingHealth

@export var regen_rate: float

func deal_damage(val: float, proj_team: ProjectileBase.Team) -> bool:
	var damage_dealt = super.deal_damage(val, proj_team)
	if damage_dealt:
		$Timer.start()
	return damage_dealt
	
func _process(delta):
	# Healing starts when half of the timer has passed, and then scales quadratically
	
	var time_passed =  $Timer.wait_time - $Timer.time_left
	var wait_time = $Timer.wait_time
	
	if time_passed < wait_time / 2:
		return
	
	var ratio = 2 * (time_passed - wait_time / 2) / wait_time
	var heal_amount = delta * ratio ** 2 * regen_rate * max_health
	health = min(max_health, health + heal_amount)

