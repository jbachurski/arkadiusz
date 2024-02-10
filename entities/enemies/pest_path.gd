extends PathFollow2D

const TIME_TO_PASS = 3.0

func _process(delta):
	set_progress_ratio(get_progress_ratio() + delta / TIME_TO_PASS)
	if get_progress_ratio() >= 1:
		get_parent().queue_free()
