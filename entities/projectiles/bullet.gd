extends Area2D

const MOVE_SPEED = 150.0
@export var initial: Vector2
@export var direction: Vector2
@export var enemy: bool

func start(pos: Vector2, dir: Vector2, en: bool) -> void:
	initial = pos
	direction = dir.normalized()
	enemy = en
	position = initial

func _between(x, a, b):
	return a <= x and x <= b

func _process(delta):
	position = position + delta * MOVE_SPEED * direction

	var size = get_viewport_rect().size
	
	if not (
		_between(position.x, -0.2 * size.x, 1.2 * size.x) and
		_between(position.y, -0.2 * size.y, 1.2 * size.y)
	):
		queue_free()
