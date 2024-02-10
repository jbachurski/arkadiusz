extends PlayerBase

const SPEED = 500.0

func _process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	position = position + delta * direction * SPEED
	var size = get_viewport_rect().size
	position.x = clamp(position.x, 0, size.x)
	position.y = clamp(position.y, 0, size.y)
