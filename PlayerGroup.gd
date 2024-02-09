extends CanvasGroup


func _ready():
	pass

func _process(delta):
	$PlayerRefl.position = Vector2(
		get_viewport_rect().size.x - $Player.position.x,
		$Player.position.y
	)
