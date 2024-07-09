extends Area3D

func _ready():
	$Label.hide()

func _on_Area_body_entered(body):
	if body.name == "player" and Globals.kills < 100:
		$Label.show()
		$Timer.start()
	elif body.name == "player" and Globals.kills >= 100:
		get_tree().change_scene_to_file("res://end.tscn")

func _on_Timer_timeout():
	$Label.hide()
