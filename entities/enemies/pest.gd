extends Area2D

func _on_death():
	self.queue_free()

func _ready():
	$Health.connect("death", _on_death)
