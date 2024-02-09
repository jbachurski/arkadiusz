extends PlayerBase

const SPEED = 500.0

func _process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	position = position + delta * direction * SPEED
