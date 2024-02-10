extends Node2D

var t: float = 0.0
var base_scale: float = randf_range(0.6, 1.4)
const TIME_TO_PERIOD = 5.0
const FALL_SPEED = 25.0
@onready var size: Vector2i = get_viewport_rect().size

func fall(delta):
	t += delta
	position.y = position.y + delta * FALL_SPEED
	if position.y > 1.05 * size.y:
		queue_free()
	else:
		queue_redraw()

func _process(delta):
	fall(delta)

func _draw():
	var radius = base_scale * (1 + 2 * sin(t * (TIME_TO_PERIOD / PI))**2)
	draw_circle(Vector2(0.0, 0.0), radius, Color.ANTIQUE_WHITE)
