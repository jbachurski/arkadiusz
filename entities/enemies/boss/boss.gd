extends Area2D

const BULLET = preload("res://entities/projectiles/bullet.tscn")
@onready var size = get_viewport_rect().size
var beams_so_far: int = 0
var active_aims = {}


func sleep(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _on_death():
	queue_free()

func _attacks():
	await sleep(3.0)
	while true:
		await _beam_attack()
		await sleep(2.0)
		await _partition_attack_set(8)
		await sleep(3.0)
		await get_parent().add_sweeper_wave(3)
		await sleep(1.0)

func _ready():
	$AnimatedSprite2D.play("default")
	$Health.connect("death", _on_death)
	_attacks()

func _beam_at(target: Vector2):
	var this = beams_so_far
	beams_so_far += 1
	var dir = (target - position).normalized()
	const delays = [0.2, 0.1, 0.5, 0.1]
	for i in range(len(delays)):
		if i % 2 == 0:
			active_aims[this] = dir
		else:
			active_aims.erase(this)
		await sleep(delays[i])
	active_aims.erase(this)
	for i in range(75):
		var b = BULLET.instantiate()
		b.start(position, dir, 1000, 1.5, ProjectileBase.Team.ENEMY)
		get_parent().add_child(b)
		await sleep(0.02)

func _beam_attack():
	var player_pos: Vector2 = $/root/Game/Friendlies/PlayerGroup/Player.position
	var player_alt_pos: Vector2 = $/root/Game/Friendlies/PlayerGroup/PlayerRefl.position
	_beam_at((player_pos + player_alt_pos) / 2)
	await sleep(1.5)
	player_pos = $/root/Game/Friendlies/PlayerGroup/Player.position
	player_alt_pos = $/root/Game/Friendlies/PlayerGroup/PlayerRefl.position
	_beam_at(player_pos)
	_beam_at(player_alt_pos)
	await sleep(1.5)
	player_pos = $/root/Game/Friendlies/PlayerGroup/Player.position
	player_alt_pos = $/root/Game/Friendlies/PlayerGroup/PlayerRefl.position
	_beam_at(player_pos)
	_beam_at(player_alt_pos)

func _beam_attack_set(c: int):
	for i in range(c):
		await _beam_attack()
		await sleep(3.0)


func _partition_attack():
	var patterns = [
		"++  + + ",
		"++   + +",
		"  +++ + ",
		"  ++ + +",
		"+ + ++  ",
		"+ +   ++",
		" + +++  ",
		" + +  ++",
	]
	var pattern = patterns[randi_range(0, len(patterns) - 1)]
	const density = 4
	for i in range(len(pattern)):
		if pattern[i] == " ":
			continue
		for j in range(density):
			var l = i * (size.x / len(pattern))
			var r = (i + 1) * (size.x / len(pattern))
			var x = (l * j + r * (density - j)) / density - size.x / len(pattern) / density / 2
			var b = BULLET.instantiate()
			var pos = Vector2(x, -0.05 * size.y)
			b.start(pos, Vector2(0, 1), 200, 1.5, ProjectileBase.Team.ENEMY)
			get_parent().add_child(b)

func _partition_attack_set(c: int):
	for i in range(c):
		_partition_attack()
		await sleep(2.0)

func cube(x):
	return x * x * x

func _process(delta: float) -> void:
	var target = size * Vector2(0.5, 0.2)
	position += (cube((target - position) / 100) + (target - position) / 500) * delta * 250
	queue_redraw()

func _draw():
	for dir in active_aims.values():
		draw_line(Vector2.ZERO, dir * 2000, Color.SKY_BLUE, 3.0)
