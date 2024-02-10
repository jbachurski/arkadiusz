extends Node2D

const BULLET = preload("res://entities/projectiles/bullet.tscn")

func shoot():
	var dir = Vector2(0, 1)
	var b = BULLET.instantiate()
	b.start(position, dir, 350, 1, ProjectileBase.Team.ENEMY)
	get_parent().add_child(b)
