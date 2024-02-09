extends CanvasGroup


const ENEMY = preload("res://entities/enemies/enemy.tscn")
const TIME_TO_MOB = 2.0
@export var mob_timer: float = 0.0


func reset_mob_timer():
	mob_timer = 0.0

func _ready():
	reset_mob_timer()

func _process(delta):
	mob_timer += delta
	if mob_timer > TIME_TO_MOB:
		var e = ENEMY.instantiate()
		var size = get_viewport_rect().size
		var pos = Vector2(randf_range(0.05, 0.95), -0.1) * size
		add_child(e)
		e.start(pos)
		reset_mob_timer()
