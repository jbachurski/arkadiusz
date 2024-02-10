extends Health
class_name PlayerHealth

func deal_damage(val: int):
	self.get_parent().get_parent().find_child("Health", false).deal_damage(val)
