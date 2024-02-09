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

func _process(delta):
	position = position + delta * MOVE_SPEED * direction
