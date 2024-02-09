extends Area2D
class_name Bullet

@export var initial: Vector2
@export var direction: Vector2
@export var enemy: bool

static func move_speed():
	return 150.0

func start(pos: Vector2, dir: Vector2, en: bool) -> void:
	initial = pos
	direction = dir.normalized()
	enemy = en
	position = initial

func _between(x, a, b):
	return a <= x and x <= b

func _process(delta):
	position = position + delta * move_speed() * direction

	var size = get_viewport_rect().size
	
	if not (
		_between(position.x, -0.2 * size.x, 1.2 * size.x) and
		_between(position.y, -0.2 * size.y, 1.2 * size.y)
	):
		queue_free()
