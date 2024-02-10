extends Area2D
class_name ProjectileBase

enum TEAM {ENEMY, PLAYER}

var damage: int
var speed: int
var direction: Vector2
var team: TEAM

func _on_collision(area: Area2D):
	if area.has_node("Health"):
		var health = area.find_child("Health", true, true)
		if health.team == team:
			return
		
		health.deal_damage(damage)
		self.queue_free()

func _ready():
	self.connect("area_entered", _on_collision)

func start(position: Vector2, dir: Vector2, speed: float, damage: int, team: TEAM) -> void:
	self.position = position
	self.damage = damage
	self.speed = speed
	self.team = team
	self.direction = dir.normalized()

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
