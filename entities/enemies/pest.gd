extends Area2D

const SPEED = preload("res://entities/powerups/speed.tscn")

func _on_death():
	if randf() <= 0.15:
		var p = SPEED.instantiate()
		var noise = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * 8
		p.position = get_global_transform_with_canvas().origin + noise
		$"/root/Game/Friendlies".add_child(p)
	queue_free()

func _ready():
	$Health.connect("death", _on_death)
	$AnimatedSprite2D.play("default")
