extends Area2D
class_name PlayerBase

const MISSILE = preload("res://entities/projectiles/missile.tscn")
var flip_left: int = 1
var flip_right: int = 1

func shoot():
	var b = MISSILE.instantiate()
	get_parent().get_parent().add_child(b)
	b.start(position, Vector2(0, -1), 1000, 1, ProjectileBase.Team.PLAYER)

func shoot_left():
	flip_right *= -1
	if get_parent().cannon_level < 1:
		return
	var b = MISSILE.instantiate()
	get_parent().get_parent().add_child(b)
	b.start(position, Vector2(-flip_right, -1), 800, 1, ProjectileBase.Team.PLAYER)

func shoot_right():
	flip_left *= -1
	if get_parent().cannon_level < 2:
		return
	var b = MISSILE.instantiate()
	get_parent().get_parent().add_child(b)
	b.start(position, Vector2(flip_left, -1), 800, 1, ProjectileBase.Team.PLAYER)

func _on_collision(area):
	if area is Powerup:
		if area.kind() == Powerup.Kind.SPEED:
			get_parent().get_node("Player").speed_level += 1
		elif area.kind() == Powerup.Kind.CANNON:
			get_parent().cannon_level += 1
		area.queue_free()

func _ready():
	self.connect("area_entered", _on_collision)

