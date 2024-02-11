extends Control

func _ready():
	$TextureProgressBar.max_value = $/root/Game/Friendlies/PlayerGroup/Health.max_health

func _process(delta):
	$TextureProgressBar.value = $/root/Game/Friendlies/PlayerGroup/Health.health
	
