extends CanvasGroup


func _ready():
	$Health.connect("death", _on_death)

func _on_death():
	print("YOU DIED")

func _process(delta):
	$PlayerRefl.position = Vector2(
		get_viewport_rect().size.x - $Player.position.x,
		$Player.position.y
	)
