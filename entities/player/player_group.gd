extends CanvasGroup

var cannon_level: int = 0

func _ready():
	$Health.connect("death", _on_death)
	$ShootTimer.connect("timeout", $PlayerRefl.shoot)
	$ShootTimer.connect("timeout", $Player.shoot)
	$PlayerRefl.flip_sides = -1

func _on_death():
	print("YOU DIED")

func _process(_delta):
	$PlayerRefl.position = Vector2(
		get_viewport_rect().size.x - $Player.position.x,
		$Player.position.y
	)
