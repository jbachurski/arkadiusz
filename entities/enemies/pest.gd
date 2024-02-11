extends Area2D

const SPEED = preload("res://entities/powerups/speed.tscn")

@export var damage: int = 1 
@export var score_value: int = 1

func real_position():
	return get_global_transform_with_canvas().origin

func _on_death():
	if randf() <= 0.12:
		var p = SPEED.instantiate()
		var noise = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * 8
		p.position = real_position() + noise
		$"/root/Game/Friendlies".call_deferred("add_child", p)
	queue_free()
	$/root/Game/UI/Score.score += score_value

func _on_collision(area: Area2D):
	if area.has_node("Health"):
		if area.find_child("Health").deal_damage(damage, $Health.team):
			_on_death()

func _ready():
	$Health.connect("death", _on_death)
	$AnimatedSprite2D.play("default")
	connect("area_entered", _on_collision)
