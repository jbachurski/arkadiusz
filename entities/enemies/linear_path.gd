extends PathFollow2D

@export var time_to_pass: float = 3.0

func _process(delta):
	set_progress_ratio(get_progress_ratio() + delta / time_to_pass)
	if get_progress_ratio() >= 1:
		get_parent().queue_free()
