extends Area2D
class_name PlayerBase

const MISSILE = preload("res://entities/projectiles/missile.tscn")

func shoot():
	var b = MISSILE.instantiate()
	get_parent().get_parent().add_child(b)
	b.start(position, Vector2(0, -1), 1000, 1, ProjectileBase.TEAM.PLAYER)
