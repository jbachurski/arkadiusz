extends Area2D
class_name Enemy

const BULLET = preload("res://entities/projectiles/bullet.tscn")
const DEFENSE = preload("res://entities/powerups/defense.tscn")
const WAVE_RANGE = 50
const FALL_SPEED = 250
const LIVE_NORM = 1

@export var live: float = 0.0
@export var initial: Vector2
@export var score_value: int = 2

func sleep(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _on_death():
	if randf() <= 0.05:
		var p = DEFENSE.instantiate()
		var noise = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * 12
		p.position = get_global_transform_with_canvas().origin + noise
		$"/root/Game/Friendlies".call_deferred("add_child", p)
	self.queue_free()
	$/root/Game/UI/Score.score += score_value

func _on_damage():
	$AnimatedSprite2D.modulate = Color(3, 3, 3)
	await sleep(0.06)
	$AnimatedSprite2D.modulate = Color(1, 1, 1)
	

func _ready():
	$Health.connect("death", _on_death)
	$Health.connect("damage", _on_damage)
	$AnimatedSprite2D.play("default")

func start(pos: Vector2) -> void:
	initial = pos
	position = initial
	_reset_shoot_timer()
	$ShootTimer.connect("timeout", _on_shoot_timer_timeout)
	$ShootTimer.connect("timeout", $/root/Game/Sounds/EnemyLaser.play)
	$ShootTimer.start($ShootTimer.time_left / 2)


func _reset_shoot_timer():
	$ShootTimer.start(randf_range(1, 2.5))
	
func _shoot_at(target: Vector2):
	var dir = (target - position).normalized()
	var b = BULLET.instantiate()
	b.start(position, dir, 350, 1, ProjectileBase.Team.ENEMY)
	get_parent().add_child(b)

func _on_shoot_timer_timeout():
	var player_pos: Vector2 = $"/root/Game/Friendlies/PlayerGroup/Player".position
	var player_alt_pos: Vector2 = $"/root/Game/Friendlies/PlayerGroup/PlayerRefl".position
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
