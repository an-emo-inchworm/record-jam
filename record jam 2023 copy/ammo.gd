extends Area3D

func _ready():
	set_as_top_level(true)
	$AnimationPlayer.play("New Anim")

func _on_Area_body_entered(body):
	if body.name == "player":
		var temp = Globals.bullets + 10
		if temp >= 20:
			Globals.bullets = 20
		else:
			Globals.bullets += 10 
		body.ammo_left.text = str(Globals.bullets)
		$pick.play()
		$CollisionShape3D.disabled = true
		$pick.connect("finished", Callable(self, "finish"))
		
func finish():
	queue_free()
		
		

