extends Area2D
class_name PlayerBase

const MISSILE = preload("res://entities/projectiles/missile.tscn")

func _on_shoot_timer_timeout():
	var b = MISSILE.instantiate()
	get_parent().get_parent().add_child(b)
	b.start(position, Vector2(0, -1), 500, 1, ProjectileBase.TEAM.PLAYER)

func _ready():
	$ShootTimer.connect("timeout", _on_shoot_timer_timeout)

