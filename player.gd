extends CharacterBody2D

const SPEED = 400.0 * 60.0

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = delta * direction * SPEED
	move_and_slide()
