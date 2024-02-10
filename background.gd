extends ColorRect

const STAR = preload("res://deco/star.tscn")

func _spawn_star():
	var s = STAR.instantiate()
	var siz = get_viewport_rect().size
	s.position = Vector2(randf_range(0.01, 0.99), -0.05) * siz
	add_child(s)

func _ready():
	$StarTimer.connect("timeout", _spawn_star)


