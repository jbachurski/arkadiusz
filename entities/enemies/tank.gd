extends Area2D
class_name Tank

const BULLET = preload("res://entities/projectiles/bullet.tscn")
const FIRE = preload("res://entities/powerups/fire.tscn")
const WAVE_RANGE = 100
const FALL_SPEED = 100
const LIVE_NORM = 1

@export var live: float = 0.0
@export var initial: Vector2
var target_y: float = 100

func _on_death():
	for i in range((randi_range(0, 4) + 1) / 2):
		var p = FIRE.instantiate()
		var noise = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * 20
		p.position = get_global_transform_with_canvas().origin + noise
		$"/root/Game/Friendlies".call_deferred("add_child", p)
	self.queue_free()

func _ready():
	$Health.connect("death", _on_death)
	$AnimatedSprite2D.play("default")

func start(pos: Vector2) -> void:
	initial = pos
	target_y = randf_range(100, 200)
	position = initial
	_reset_shoot_timer()
	$ShootTimer.connect("timeout", _on_shoot_timer_timeout)
	$ShootTimer.start($ShootTimer.time_left / 2)


func _reset_shoot_timer():
	$ShootTimer.start(randf_range(1, 2.5))

func _shoot_at(target: Vector2):
	var dir = (target - position).normalized()
	var b = BULLET.instantiate()
	b.start(position, dir, 600, 1, ProjectileBase.Team.ENEMY)
	get_parent().add_child(b)


func _on_shoot_timer_timeout():
	var player_pos: Vector2 = $"/root/Game/Friendlies/PlayerGroup/Player".position
	var player_alt_pos: Vector2 = $"/root/Game/Friendlies/PlayerGroup/PlayerRefl".position
	if randi() % 2 == 1:
		await _shoot_at(player_pos)
	else:
		await _shoot_at(player_alt_pos)

func _process(delta):
	position = Vector2(
		initial.x + sin(live) * WAVE_RANGE, 
		position.y + delta * FALL_SPEED * tanh(target_y - position.y)
	)
	live += delta * LIVE_NORM

	var h = get_viewport_rect().size.y
	if not (-0.2 * h < position.y and position.y < 1.2 * h):
		queue_free()
