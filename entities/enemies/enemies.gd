extends CanvasGroup

const TANK = preload("res://entities/enemies/tank.tscn")
const SWEEPER = preload("res://entities/enemies/sweeper.tscn")
const PEST = preload("res://entities/enemies/pest.tscn")
const ENEMY = preload("res://entities/enemies/enemy.tscn")
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
	Wave.new(1.0, wave1),
	Wave.new(0.5, wave2)
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

func wave1():
	add_tank(Vector2(randf_range(0.25, 0.75), randf_range(-0.2, -0.1)) * size)
	await sleep(3)
	await add_pest_wave(6)
	for i in range(4):
		add_child(next_sweeper(Vector2(randf_range(0.0, 0.3), randf_range(-0.05, -0.02)) * size))
		add_child(next_sweeper(Vector2(randf_range(0.7, 1.0), randf_range(-0.05, -0.02)) * size, true))
		await sleep(2)
	await add_pest_refl_wave(6)
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


func run_waves():
	for wave in WAVES:
		await sleep(wave.delay)
		await wave.start()

func _ready():
	run_waves()
