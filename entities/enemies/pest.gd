extends Area2D

const SPEED = preload("res://entities/powerups/speed.tscn")

@export var damage: int = 1 

func _on_death():
	if randf() <= 0.25:
		var p = SPEED.instantiate()
		var noise = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * 8
		p.position = get_global_transform_with_canvas().origin + noise
		$"/root/Game/Friendlies".add_child(p)
	queue_free()

func _on_collision(area: Area2D):
	if area.has_node("Health"):
		var health = area.find_child("Health")
		if health.team == $Health.team:
			return

		health.deal_damage(damage)
		self.queue_free()

func _ready():
	$Health.connect("death", _on_death)
	$AnimatedSprite2D.play("default")
	connect("area_entered", _on_collision)
