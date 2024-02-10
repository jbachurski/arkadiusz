extends Area2D

class_name Shield
@export var health: Health
@export var area: CollisionShape2D

func _on_death():
	self.queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Health.connect("death", _on_death)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
