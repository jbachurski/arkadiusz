extends ColorRect

const STAR = preload("res://deco/star.tscn")

func _spawn_star():
	var s = STAR.instantiate()
	var siz = get_viewport_rect().size
	s.position = Vector2(randf_range(0.01, 0.99), -0.05) * siz
	$Stars.add_child(s)
	return s

func _ready():
	$StarTimer.connect("timeout", _spawn_star)
	for i in range(25):
		_spawn_star().fall(i * $StarTimer.wait_time)
