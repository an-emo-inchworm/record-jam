extends RigidBody3D

var speed = 10
var shoot = false

func _ready():
	set_as_top_level(true)

func _physics_process(delta):
	if shoot:
		apply_impulse(-transform.basis.z * speed, transform.basis.z)


func _on_Area_body_entered(body):
	queue_free()
		
