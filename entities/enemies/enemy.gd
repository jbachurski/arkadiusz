extends Area2D
class_name Enemy

const BULLET = preload("res://entities/projectiles/bullet.tscn")
const WAVE_RANGE = 70
const FALL_SPEED = 50
const LIVE_NORM = 1

@export var live: float = 0.0
@export var initial: Vector2

func start(pos: Vector2) -> void:
	initial = pos
	position = initial
	_reset_shoot_timer()
	$ShootTimer.connect("timeout", _on_shoot_timer_timeout)

func _reset_shoot_timer():
	$ShootTimer.start(randf_range(2, 3))

func _on_shoot_timer_timeout():
	var b = BULLET.instantiate()
	b.start(position, Vector2(0, 1), 150, 1)
	get_parent().add_child(b)
	_reset_shoot_timer()

func _process(delta):
	position = Vector2(initial.x + sin(live) * WAVE_RANGE, initial.y + live * FALL_SPEED)
	live += delta * LIVE_NORM

	var h = get_viewport_rect().size.y
	if not (-0.2 * h < position.y and position.y < 1.2 * h):
		queue_free()
