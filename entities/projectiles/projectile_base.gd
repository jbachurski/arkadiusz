extends Area2D
class_name ProjectileBase

var damage: int
var speed: int
var direction: Vector2

func start(position: Vector2, dir: Vector2, speed: float, damage: int) -> void:
	self.position = position
	self.damage = damage
	self.speed = speed
	direction = dir.normalized()

func _between(x, a, b):
	return a <= x and x <= b

func _process(delta):
	position = position + delta * speed * direction
	
	var size = get_viewport_rect().size
	
	if not (
		_between(position.x, -0.2 * size.x, 1.2 * size.x) and
		_between(position.y, -0.2 * size.y, 1.2 * size.y)
	):
		queue_free()
