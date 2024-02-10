extends Area2D
class_name Enemy

const BULLET = preload("res://entities/projectiles/bullet.tscn")
const WAVE_RANGE = 50
const FALL_SPEED = 250
const LIVE_NORM = 1

@export var live: float = 0.0
@export var initial: Vector2

func _on_death():
	self.queue_free()

func _ready():
	$Health.connect("death", _on_death)
	$AnimatedSprite2D.play("default")

func start(pos: Vector2) -> void:
	initial = pos
	position = initial
	_reset_shoot_timer()
	$ShootTimer.connect("timeout", _on_shoot_timer_timeout)
	$ShootTimer.connect("timeout", $LaserAudio.play)


func _reset_shoot_timer():
	$ShootTimer.start(randf_range(2, 3))
	
func _shoot_at(target: Vector2):
	var dir = (target - position).normalized()
	var b = BULLET.instantiate()
	b.start(position, dir, 350, 1, ProjectileBase.Team.ENEMY)
	get_parent().add_child(b)

func _on_shoot_timer_timeout():
	var player_pos : Vector2 = $"../../Friendlies/PlayerGroup/Player".position
	var player_alt_pos : Vector2 = $"../../Friendlies/PlayerGroup/PlayerRefl".position
	if (player_pos - position).abs() <= (player_alt_pos - position).abs():
		_shoot_at(player_pos)
	else:
		_shoot_at(player_alt_pos)
	
	_reset_shoot_timer()

func _process(delta):
	position = Vector2(initial.x + sin(live) * WAVE_RANGE, initial.y + live * FALL_SPEED)
	live += delta * LIVE_NORM

	var h = get_viewport_rect().size.y
	if not (-0.2 * h < position.y and position.y < 1.2 * h):
		queue_free()
