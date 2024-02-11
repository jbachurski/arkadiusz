extends Node

func vulnerable():
	return $Timer.is_stopped()

func reset_iframes():
	$Timer.start()
