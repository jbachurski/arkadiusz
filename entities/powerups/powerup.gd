extends Node2D
class_name Powerup

const MOVE_SPEED = 70.0

enum Kind {SPEED, CANNON, FIRE, DEFENSE}

static func kind():
	return null

func _process(delta):
	position.y = position.y + delta * MOVE_SPEED

	if position.y > 1.1 * get_viewport_rect().size.y:
		queue_free()
