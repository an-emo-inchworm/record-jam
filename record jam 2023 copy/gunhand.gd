extends Node3D

func _ready():
	$AnimatedSprite3D.play("default")
func shoot():
	if $AnimationPlayer.is_playing():
		pass
	else:
		$AnimationPlayer.play("kick")
