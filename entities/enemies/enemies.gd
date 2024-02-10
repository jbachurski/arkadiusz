extends CanvasGroup


const PEST = preload("res://entities/enemies/pest.tscn")
const ENEMY = preload("res://entities/enemies/enemy.tscn")

class Wave:
	var delay
	var fun
	
	func _init(d, f):
		delay = d
		fun = f
		
	func start():
		await fun.call()


var WAVES = [
	Wave.new(2.5, wave1),
	Wave.new(7.5, wave2)
]

func sleep(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func wave1():
	for i in range(5):
		var e = PEST.instantiate()
		var size = get_viewport_rect().size
		var pos = Vector2(0.2, -0.1) * size
		e.position = pos
		add_child(e)
		await sleep(0.4)

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
