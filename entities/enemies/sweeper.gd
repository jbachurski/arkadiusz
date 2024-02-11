extends Area2D

const BULLET = preload("res://entities/projectiles/bullet.tscn")
const FIRE = preload("res://entities/powerups/fire.tscn")

func sleep(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

@export var damage: int = 1 
@export var score_value: int = 3
var flip: bool = false

func real_position():
	return get_global_transform_with_canvas().origin

func _on_death():
	if randf() <= 0.011:
		var p = FIRE.instantiate()
		var noise = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * 4
		p.position = real_position() + noise
		$"/root/Game/Friendlies".call_deferred("add_child", p)
	queue_free()
	$/root/Game/UI/Score.score += score_value

func _on_damage():
	$AnimatedSprite2D.modulate = Color(3, 3, 3)
	await sleep(0.06)
	$AnimatedSprite2D.modulate = Color(1, 1, 1)
	
func _shoot_at(target: Vector2):
	var dir = (target - real_position()).normalized()
	var b = BULLET.instantiate()
	b.start(real_position(), dir, 350, 1, ProjectileBase.Team.ENEMY)
	get_parent().get_parent().get_parent().add_child(b) # xD refer to actual Enemies

func _on_shoot_timer_timeout():
	var player_pos: Vector2 = $"/root/Game/Friendlies/PlayerGroup/Player".position
	var player_alt_pos: Vector2 = $"/root/Game/Friendlies/PlayerGroup/PlayerRefl".position
	flip = not flip
	if flip:
		_shoot_at(player_pos)
	else:
		_shoot_at(player_alt_pos)

func _ready():
	$Health.connect("death", _on_death)
	$Health.connect("damage", _on_damage)
	$AnimatedSprite2D.play("default")
	$ShootTimer.connect("timeout", _on_shoot_timer_timeout)
	$ShootTimer.connect("timeout", $/root/Game/Sounds/EnemyLaser.play)
