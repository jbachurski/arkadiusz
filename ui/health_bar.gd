extends Control

func _process(delta):
	$TextureProgressBar.max_value = $/root/Game/Friendlies/PlayerGroup/Health.max_health
	$TextureProgressBar.value = $/root/Game/Friendlies/PlayerGroup/Health.health
	
