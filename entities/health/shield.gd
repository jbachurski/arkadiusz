extends Area2D

class_name Shield
@export var max_health: int = 2

func sleep(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _on_death():
	self.queue_free()

func _on_damage():
	$FlashSprite2D.visible = true
	await sleep(0.05)
	$FlashSprite2D.visible = false

func _ready():
	$Health.max_health = max_health
	$Health.health = max_health
	$Health.connect("death", _on_death)
	$Health.connect("damage", _on_damage)
