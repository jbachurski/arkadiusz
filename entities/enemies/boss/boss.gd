extends Area2D

func _ready():
	$AnimatedSprite2D.play("default")
	$MainGunTimer.connect("timeout", $BossGun.shoot)
	$MainGunTimer.connect("timeout", $BossGun2.shoot)	
