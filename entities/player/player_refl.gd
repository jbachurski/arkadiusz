extends PlayerBase

const MISSILE_PURPLE = preload("res://entities/projectiles/missile_purple.tscn")

func get_projectile():
	return MISSILE_PURPLE.instantiate()
