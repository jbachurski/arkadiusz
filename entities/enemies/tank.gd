extends Area2D
class_name Tank

const BULLET = preload("res://entities/projectiles/bullet.tscn")
const FIRE = preload("res://entities/powerups/fire.tscn")
const WAVE_RANGE = 100
const FALL_SPEED = 100
const LIVE_NORM = 1

var live: float = 0.0
var target_y: float = 100
var aim_dir = null
var wave_speed: float = 1.0
var last_live: float = 0.0

func _on_death():
	while true:
		var p = FIRE.instantiate()
		var noise = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * 20
		p.position = get_global_transform_with_canvas().origin + noise
		$"/root/Game/Friendlies".call_deferred("add_child", p)
		if randi_range(0, 1) == 0:
			break
	self.queue_free()

func _ready():
	target_y = randf_range(100, 200)
	$ShootTimer.connect("timeout", _on_shoot_timer_timeout)
	$ShootTimer.connect("timeout", $/root/Game/Sounds/EnemyLaser.play)
	$Health.connect("death", _on_death)
	$AnimatedSprite2D.play("default")

func sleep(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _shoot_at(target: Vector2):
	var dir = (target - position).normalized()
	const delays = [0.2, 0.1, 0.2, 0.1, 0.2, 0.1, 0.4, 0.1]
	last_live = live
	for i in range(len(delays)):
		aim_dir = dir if i % 2 == 0 else null
		await sleep(delays[i])
		wave_speed *= (1 - 2.0/len(delays))
	wave_speed = 0
	aim_dir = null
	
	$/root/Game/Sounds/EnemyBeamLaser.play()
	for i in range(100):
		var b = BULLET.instantiate()
		b.start(position, dir, 1000, 1, ProjectileBase.Team.ENEMY)
		get_parent().add_child(b)
		await sleep(0.02)
	$/root/Game/Sounds/EnemyBeamLaser.stop()
	wave_speed = 1
	live = last_live

func _on_shoot_timer_timeout():
	var player_pos: Vector2 = $"/root/Game/Friendlies/PlayerGroup/Player".position
	var player_alt_pos: Vector2 = $"/root/Game/Friendlies/PlayerGroup/PlayerRefl".position
	_shoot_at((player_pos + player_alt_pos) / 2)

func _process(delta):
	var left_stop = 0.3 * get_viewport_rect().size.x
	var right_stop = 0.7 * get_viewport_rect().size.x
	var correction: float = 0.0
	if position.x < left_stop:
		correction = 2 * (left_stop - position.x) / get_viewport_rect().size.x
	elif position.x > right_stop:
		correction = -2 * (position.x - right_stop) / get_viewport_rect().size.x
	position = Vector2(
		position.x + delta * (cos(live) + correction) * wave_speed * WAVE_RANGE, 
		position.y + delta * FALL_SPEED * tanh(target_y - position.y)
	)
	live += delta * LIVE_NORM
	queue_redraw()

	var h = get_viewport_rect().size.y
	if not (-0.2 * h < position.y and position.y < 1.2 * h):
		queue_free()

func _draw():
	if aim_dir != null:
		draw_line(Vector2.ZERO, aim_dir * 2000, Color.SKY_BLUE, 3.0)

