extends Label

var score: int = 0

func _process(delta):
	text = ("%05d" % score) + "00"

