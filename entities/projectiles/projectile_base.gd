extends Area2D
class_name ProjectileBase

enum Team {ENEMY, PLAYER}

var damage: int
var speed: int
var direction: Vector2
var team: Team

func _on_collision(area: Area2D):
	if area.has_node("Shield"):
		return
	
	if area.has_node("Health"):
		var health = area.find_child("Health")
		if health.team == team:
			return

		if health.deal_damage(damage, team):
			self.queue_free()
	
	if area is Shield:
		direction = direction.bounce((global_position - area.global_position).normalized()).normalized()
		rotation = direction.rotated(PI / 2).angle()
		return

func _ready():
	self.connect("area_entered", _on_collision)

func start(pos: Vector2, dir: Vector2, spd: float, dmg: int, tm: Team) -> void:
	position = pos
	damage = dmg
	speed = spd
	team = tm
	direction = dir.normalized()
	rotation = dir.rotated(PI / 2).angle()

func _between(x, a, b):
	return a <= x and x <= b

func _process(delta):
	position = position + delta * speed * direction
	
	var size = get_viewport_rect().size
	
	if not (
		_between(position.x, -0.2 * size.x, 1.2 * size.x) and
		_between(position.y, -0.2 * size.y, 1.2 * size.y)
	):
		queue_free()
