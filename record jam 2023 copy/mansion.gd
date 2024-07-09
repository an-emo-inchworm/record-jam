extends Area3D



func _on_StaticBody_body_entered(body):
	if body.name == "player":
		get_tree().change_scene_to_file("res://mansionscene.tscn")
