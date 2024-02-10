extends CanvasGroup

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
	Wave.new(0.5, wave1),
	Wave.new(7.5, wave2)
]

func sleep(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout


func next_pest(pos):
	var e = PEST.instantiate()
	e.position = pos
	return e

func next_pest_refl(pos):
	var e = next_pest(pos)
	e.curve = e.curve.duplicate()
	for p in range(e.curve.get_point_count()):
		e.curve.set_point_position(p, Vector2(-1, 1) * e.curve.get_point_position(p))
	return e

func wave1():
	add_child(next_pest_refl(Vector2(0.5, 0) * size))
	for i in range(5):
		var pos = Vector2(0.25, -0.1) * size
		add_child(next_pest(pos))
		await sleep(0.5)
	await sleep(2.5)
	for i in range(5):
		var pos = Vector2(0.75, -0.1) * size
		add_child(next_pest_refl(pos))
		await sleep(0.5)

func wave2():
	var e = ENEMY.instantiate()
	var size = get_viewport_rect().size
	var pos = Vector2(randf_range(0.05, 0.95), -0.1) * size
	add_child(e)
	e.start(pos)

func run_waves():
	for wave in WAVES:
		print(wave.fun)
		await sleep(wave.delay)
		await wave.start()

func _ready():
	run_waves()
