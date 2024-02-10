extends Area2D
class_name PlayerBase

const MISSILE = preload("res://entities/projectiles/missile.tscn")

func shoot():
	var b = MISSILE.instantiate()
	get_parent().get_parent().add_child(b)
	b.start(position, Vector2(0, -1), 1000, 1, ProjectileBase.TEAM.PLAYER)

func _on_collision(area: Area2D):
	if area.name == "Speed":
		$"../Player".speed_level += 1
		print(area, " ", $"../Player".speed_level)
		area.queue_free()


func _ready():
	$ShootTimer.connect("timeout", _on_shoot_timer_timeout)
	self.connect("area_entered", _on_collision)

