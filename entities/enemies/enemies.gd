extends CanvasGroup

const TANK = preload("res://entities/enemies/tank.tscn")
const SWEEPER = preload("res://entities/enemies/sweeper.tscn")
const PEST = preload("res://entities/enemies/pest.tscn")
const ENEMY = preload("res://entities/enemies/enemy.tscn")
const BOSS = preload("res://entities/enemies/boss/boss.tscn")
@onready var size = get_viewport_rect().size

class Wave:
	var delay
	var fun
	
	func _init(d, f):
		delay = d
		fun = f
		
	func start():
		await fun.call()

var WAVES = [
	#Wave.new(1.0, wave_boss),
	#Wave.new(1.0, wave1),
	#Wave.new(0.5, wave2)
	Wave.new(7.0, intro_wave),
	Wave.new(2.0, main_wave),
	Wave.new(2.0, tank_wave),
	Wave.new(5.0, wave_boss)
]

func sleep(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout


func next_pest(pos, refl: bool = false):
	var e = PEST.instantiate()
	e.position = pos
	if refl:
		e.curve = e.curve.duplicate()
		for p in range(e.curve.get_point_count()):
			e.curve.set_point_position(p, Vector2(-1, 1) * e.curve.get_point_position(p))
	return e


func next_sweeper(pos, refl: bool = false):
	var e = SWEEPER.instantiate()
	e.position = pos
	if refl:
		e.curve = e.curve.duplicate()
		for p in range(e.curve.get_point_count()):
			e.curve.set_point_position(p, Vector2(-1, 1) * e.curve.get_point_position(p))
	return e
	

func add_tank(pos):
	var e = TANK.instantiate()
	e.position = pos
	add_child(e)
	return e

	
func add_pest_wave(c: int):
	for i in range(c):
		var pos = Vector2(0.25, -0.1) * size
		add_child(next_pest(pos))
		await sleep(0.33)
	await sleep(1.5)

func add_pest_refl_wave(c: int):
	for i in range(c):
		var pos = Vector2(0.75, -0.1) * size
		add_child(next_pest(pos, true))
		await sleep(0.33)
	await sleep(2)

func add_sweeper_wave(c: int):
	for i in range(c):
		add_child(next_sweeper(Vector2(randf_range(0.0, 0.3), randf_range(-0.05, -0.02)) * size))
		add_child(next_sweeper(Vector2(randf_range(0.7, 1.0), randf_range(-0.05, -0.02)) * size, true))
		await sleep(2.0)

func intro_wave():
	await add_pest_wave(6)
	await add_pest_refl_wave(6)
	await sleep(2.0)
	add_sweeper_wave(6)
	await sleep(4.0)
	add_pest_wave(3)
	add_sweeper_wave(2)
	await add_pest_refl_wave(3)
	await sleep(2.0)

func add_dual_enemy(symmetrical: bool):
	var pos1 = Vector2(randf_range(0.05, 0.95), -0.1) * size
	var pos2 = Vector2(1 - pos1.x, -0.1) * size
	if not symmetrical:
		pos2 = Vector2(randf_range(0.05, 0.95), -0.1) * size
	var e1 = ENEMY.instantiate()
	var e2 = ENEMY.instantiate()
	add_child(e1)
	add_child(e2)
	e1.start(pos1)
	e2.start(pos2)

func main_wave():
	for i in range(10):
		add_dual_enemy(i % 2 == 0)
		await sleep(2)
	await add_pest_wave(4)
	await add_pest_refl_wave(4)
	for i in range(5):
		add_sweeper_wave(1)
		add_dual_enemy(i % 2 == 0)
		await sleep(5)

func tank_wave():
	add_tank(Vector2(0.5, -0.1) * size)
	await add_sweeper_wave(10)
	for i in range(5):
		add_sweeper_wave(1)
		add_dual_enemy(i % 2 == 0)
		await sleep(5)
	add_tank(Vector2(0.3, -0.1) * size)
	await add_sweeper_wave(8)
	await sleep(3)
	await add_pest_wave(4)
	await add_pest_refl_wave(4)
	await sleep(3)
	add_tank(Vector2(0.5, -0.1) * size)
	await sleep(1)
	add_tank(Vector2(0.2, -0.1) * size)
	await sleep(1)
	add_tank(Vector2(0.8, -0.1) * size)
	await sleep(30)

func wave1():
	add_tank(Vector2(randf_range(0.25, 0.75), randf_range(-0.2, -0.1)) * size)
	await sleep(3)
	await add_pest_wave(6)
	await add_pest_refl_wave(6)
	await add_sweeper_wave(4)
	add_pest_wave(4)
	await add_pest_refl_wave(4)
	await sleep(2.0)

func add_enemy():
	var e = ENEMY.instantiate()
	var pos = Vector2(randf_range(0.05, 0.95), -0.1) * size
	add_child(e)
	e.start(pos)

func wave2():
	while true:
		add_enemy()
		await sleep(randf_range(0, 0.2))
		add_enemy()
		await sleep(1.5)

func change_music():
	var tween = get_tree().create_tween()
	var transition_duration = 7.00
	var main_theme = $/root/Game/Sounds/MainTheme
	var boss_theme = $/root/Game/Sounds/BossTheme
	
	boss_theme.play()
	tween.tween_property(main_theme, "volume_db", -30, transition_duration)
	tween.parallel().tween_property(boss_theme, "volume_db", 0, transition_duration)
	tween.tween_callback(main_theme.stop)
	
	await tween.finished

func wave_boss():
	await change_music()
	
	var e = BOSS.instantiate()
	var pos = Vector2(randf_range(0.4, 0.6), -0.2) * size
	e.position = pos
	add_child(e)
	

func run_waves():
	for wave in WAVES:
		await sleep(wave.delay)
		await wave.start()

func _ready():
	run_waves()
