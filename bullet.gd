extends Area2D

const MOVE_SPEED = 150.0
@export var initial: Vector2
@export var direction: Vector2

func start(pos: Vector2, dir: Vector2):
	initial = pos
	direction = dir.normalized()
	position = initial

func _process(delta):
	position = position + delta * MOVE_SPEED * direction
