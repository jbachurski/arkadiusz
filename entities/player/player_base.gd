extends Area2D
class_name PlayerBase

const MISSILE_RED = preload("res://entities/projectiles/missile_red.tscn")
var flip_sides: int = 1
var since_side: int = 0

func get_projectile():
	return MISSILE_RED.instantiate()

func shoot():
	var b = get_projectile()
	get_parent().get_parent().add_child(b)
	b.start(position, Vector2(0, -1), 1000, 1, ProjectileBase.Team.PLAYER)
	if get_parent().cannon_level >= 1:
		since_side += 1
		if since_side >= 2:
			if get_parent().cannon_level >= 2:
				shoot_side()
				flip_sides *= -1
			shoot_side()
			flip_sides *= -1
			since_side = 0

func shoot_side():
	if get_parent().cannon_level < 1:
		return
	var b = get_projectile()
	get_parent().get_parent().add_child(b)
	b.start(position, Vector2(-flip_sides, -1), 800, 1, ProjectileBase.Team.PLAYER)

func _on_collision(area):
	if area is Powerup:
		if area.kind() == Powerup.Kind.SPEED:
			get_parent().get_node("Player").speed_level += 1
		elif area.kind() == Powerup.Kind.CANNON:
			get_parent().cannon_level += 1
		elif area.kind() == Powerup.Kind.FIRE:
			get_parent().get_node("ShootTimer").wait_time *= 0.8
		area.queue_free()
		$/root/Game/Sounds/Powerup.play()

func _ready():
	self.connect("area_entered", _on_collision)
	$AnimatedSprite2D.play("default")

