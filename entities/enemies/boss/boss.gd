extends Area2D

const BULLET = preload("res://entities/projectiles/bullet.tscn")
@onready var size = get_viewport_rect().size

func sleep(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _attacks():
	while true:
		await _beam_attack()
		await sleep(2.0)
		await _partition_attack_set(8)
		await sleep(5.0)

func _ready():
	$AnimatedSprite2D.play("default")
	_attacks()

func _beam_attack():
	pass

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
	var density = 4
	for i in range(len(pattern)):
		if pattern[i] == " ":
			continue
		for j in range(density):
			var l = i * (size.x / len(pattern))
			var r = (i + 1) * (size.x / len(pattern))
			var x = (l * j + r * (density - j)) / density
			var b = BULLET.instantiate()
			var pos = Vector2(x, -0.05 * size.y)
			b.start(pos, Vector2(0, 1), 200, 1, ProjectileBase.Team.ENEMY)
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
