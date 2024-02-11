extends TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.connect("timeout", queue_free)

