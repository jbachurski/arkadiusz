extends PlayerBase

var speed = 200.0
var speed_level = 0

func _process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	var speed_mod = 1 + 1.7 * tanh(speed_level / 12.0) + (0.3 if speed_level >= 1 else 0.0)
	position = position + delta * direction * speed * speed_mod
	var size = get_viewport_rect().size
	position.x = clamp(position.x, 0, size.x)
	position.y = clamp(position.y, 0, size.y)
