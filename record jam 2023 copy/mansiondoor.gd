extends Area3D



func _on_Area_body_entered(body):
	if body.name == "player":
		get_tree().change_scene_to_file("res://shootermapmansionexit.tscn")
