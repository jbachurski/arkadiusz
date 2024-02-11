extends Health
class_name PlayerHealth

func deal_damage(val: float, proj_team: ProjectileBase.Team):
	return self.get_parent().get_parent().find_child("Health", false).deal_damage(val, proj_team)
