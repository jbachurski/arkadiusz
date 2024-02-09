extends Area2D

const BULLET = preload("res://entities/projectiles/bullet.tscn")

func _on_shoot_timer_timeout():
	var b = BULLET.instantiate()
	get_parent().get_parent().add_child(b)
	b.start(position, Vector2(0, -1), false)

func _ready():
	$ShootTimer.connect("timeout", _on_shoot_timer_timeout)
