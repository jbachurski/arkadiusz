extends CanvasGroup

var cannon_level: int = 0

func sleep(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _on_death():
	$/root/Game/GameOver.set_visible(true)
	get_tree().paused = true
	print("YOU DIED")

func _star_rumble():
	var shift = Vector2.from_angle(randf_range(0, TAU)) * 8
	for i in range(15):
		$/root/Game/Background/Stars.position = shift * sin(i / 14.0 * TAU)
		await sleep(0.02)
	$/root/Game/Background/Stars.position = Vector2.ZERO

func _on_damage():
	var prev = $/root/Game/Background.color
	$/root/Game/Background.color = prev * Color(2, 1.5, 1.5)
	_star_rumble()
	await sleep(0.1)
	$/root/Game/Background.color = prev

func _ready():
	$Health.connect("death", _on_death)
	$Health.connect("damage", _on_damage)
	$ShootTimer.connect("timeout", $PlayerRefl.shoot)
	$ShootTimer.connect("timeout", $Player.shoot)
	$PlayerRefl.flip_sides = -1

func _process(_delta):
	$PlayerRefl.position = Vector2(
		get_viewport_rect().size.x - $Player.position.x,
		$Player.position.y
	)
