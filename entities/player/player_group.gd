extends CanvasGroup


func _ready():
	$Health.connect("death", _on_death)
	$ShootTimer.connect("timeout", $Player.shoot)
	$ShootTimer.connect("timeout", $PlayerRefl.shoot)
	$ShootTimer.connect("timeout", $LaserAudio.play)

func _on_death():
	print("YOU DIED")

func _process(delta):
	$PlayerRefl.position = Vector2(
		get_viewport_rect().size.x - $Player.position.x,
		$Player.position.y
	)
