extends PathFollow2D

const TIME_TO_PASS = 6.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_progress_ratio(get_progress_ratio() + delta / TIME_TO_PASS)
	if get_progress_ratio() >= 1:
		get_parent().queue_free()
