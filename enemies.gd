extends CanvasGroup


const ENEMY = preload("res://enemy.tscn")
const TIME_TO_MOB = 2.0
@export var mob_timer: float = 0.0


func reset_mob_timer():
	mob_timer = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_mob_timer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mob_timer += delta
	if mob_timer > TIME_TO_MOB:
		var e = ENEMY.instantiate()
		var size = get_viewport_rect().size
		var pos = Vector2(randf_range(0.2, 0.8), -0.1) * size
		add_child(e)
		e.start(pos)
		reset_mob_timer()
