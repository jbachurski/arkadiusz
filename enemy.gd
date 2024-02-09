extends Node2D

@export var live: float = 0.0
@export var initial: Vector2

# Called when the node enters the scene tree for the first time.
func start(pos: Vector2) -> void:
	initial = pos
	position = initial


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = Vector2(initial.x + sin(live) * 70, initial.y + live * 50)
	live += delta
