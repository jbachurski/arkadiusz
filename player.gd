extends Area2D

const BULLET = preload("res://bullet.tscn")
const SPEED = 500.0

func _process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	position = position + delta * direction * SPEED

	if $ShootTimer.time_left <= 0:
		var b = BULLET.instantiate()
		get_parent().get_parent().add_child(b)
		b.start(position, Vector2(0, -1), false)
		$ShootTimer.start()
	print($ShootTimer.time_left)

