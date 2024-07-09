extends CharacterBody3D

var state = floor(randf_range(0, 4))
const ACCEL =0.1
@export var speed = 0.01
@export var chasespeed = 200
var dir = 1
var target
var player_entered = false

var hit = false
@onready var nav = $NavigationAgent3D
var wall = false
var outofwall = true

func _ready():
	velocity = Vector3()
	set_as_top_level(true)
	$Area3D/AnimatedSprite3D.play("default")
	$AudioStreamPlayer3D.play()
		
func _physics_process(delta):
	var direction = Vector3()
	
	if wall == false and player_entered == false:
		
		if state == 0:
			velocity.x -= dir * speed
			
		elif state == 1:
			velocity.x += dir * speed
			
		elif state == 2:
			velocity.z += dir * speed
			
		else:
			velocity.z -= dir * speed
	
		set_velocity(velocity)
		set_up_direction(Vector3(1,1,1))
		move_and_slide()
	
	if hit == true:
		$Area3D/AnimatedSprite3D.play("death")
		$Area3D/AnimatedSprite3D.connect("animation_finished", Callable(self, "finish"))
	
	if player_entered == true:
		move_to_target(delta)
		
	if wall == true:
		dir = -1
		wall = false
		
func finish():
	queue_free()

func _on_Timer_timeout():
	state = floor(randf_range(0, 4))
	velocity.x = 0
	velocity.z = 0

func _on_Area_body_entered(body):
	if body.name == "player":
		if body.hit == true:
			pass
		else:
			body.hit = true
			body.attacked.play()
			body.hurt.show()
			body.hurt_timer.start()
			body.hit = true
			Globals.lives -= 1
			body.lives.text = str(Globals.lives)
			body.checkDead()
			body.hit_timer.start()
	elif body.is_in_group("collide"):
		wall = true


func _on_Area_body_exited(body):
	if body.is_in_group("collide"):
		wall = false
		
func _on_sight_body_entered(body):
	if body.name == "player":
		player_entered = true
		target = body
		
func _on_sight_body_exited(body):
	if body.name == "player":
		player_entered = false
		target = null

func move_to_target(delta):
	var direction = (target.transform.origin - transform.origin).normalized()
	set_velocity(direction * chasespeed * delta)
	set_up_direction(Vector3.UP)
	move_and_slide()
