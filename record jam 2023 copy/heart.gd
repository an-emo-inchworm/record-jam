extends Area3D

func _ready():
	$AnimatedSprite3D.play("default")
	$AnimationPlayer.play("New Anim")
	set_as_top_level(true)

func _on_Area_body_entered(body):
	if body.name == "player" and Globals.lives < 3:
		$pick.play()
		$AnimatedSprite3D.hide()
		$CollisionShape3D.disabled = true
		$pick.connect("finished", Callable(self, "finish"))
		Globals.lives += 1
		body.lives.text = str(Globals.lives)
		
func finish():
	queue_free()
