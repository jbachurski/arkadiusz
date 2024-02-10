extends CanvasGroup

var cannon_level: int = 0

func _ready():
	$Health.connect("death", _on_death)
	$ShootTimer.connect("timeout", $Player.shoot)
	$ShootTimer.connect("timeout", $PlayerRefl.shoot)
	$PlayerRefl.flip_left = -1
	$PlayerRefl.flip_right = -1
	$LeftShootTimer.connect("timeout", $Player.shoot_left)
	$LeftShootTimer.connect("timeout", $PlayerRefl.shoot_left)
	$RightShootTimer.connect("timeout", $Player.shoot_right)
	$RightShootTimer.connect("timeout", $PlayerRefl.shoot_right)

func _on_death():
	print("YOU DIED")

func _process(delta):
	$PlayerRefl.position = Vector2(
		get_viewport_rect().size.x - $Player.position.x,
		$Player.position.y
	)
