extends Area2D

const BULLET = preload("res://entities/projectiles/bullet.tscn")

func _process(delta):
	if $ShootTimer.time_left <= 0:
		var b = BULLET.instantiate()
		get_parent().get_parent().add_child(b)
		b.start(position, Vector2(0, -1), false)
		$ShootTimer.start()
