extends Area2D

const MOVE_SPEED = 150.0
@export var initial: Vector2

func start(pos: Vector2):
	initial = pos
	position = initial
	print(position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = position + Vector2(0, delta * MOVE_SPEED)
