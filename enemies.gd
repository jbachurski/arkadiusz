extends CanvasGroup


const ENEMY_NODE = preload("res://enemy.tscn")
const TIME_TO_MOB = 2.0
@export var mob_timer: float = 0.0
var rng = RandomNumberGenerator.new()


func reset_mob_timer():
	mob_timer = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_mob_timer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mob_timer += delta
	if mob_timer > TIME_TO_MOB:
		var e = ENEMY_NODE.instantiate()
		var size = get_viewport_rect().size
		var pos = Vector2(rng.randf_range(0, size.x), -0.1 * size.y)
		e.start(pos)
		add_child(e)
		reset_mob_timer()
