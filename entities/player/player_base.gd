extends Area2D
class_name PlayerBase

const MISSILE = preload("res://entities/projectiles/missile.tscn")

func shoot():
	var b = MISSILE.instantiate()
	get_parent().get_parent().add_child(b)
	b.start(position, Vector2(0, -1), 1000, 1, ProjectileBase.Team.PLAYER)

func _on_collision(area):
	if area is Powerup:
		if area.kind() == Powerup.Kind.SPEED:
			$"../Player".speed_level += 1
			area.queue_free()

func _ready():
	self.connect("area_entered", _on_collision)

