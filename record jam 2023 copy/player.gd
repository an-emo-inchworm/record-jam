extends CharacterBody3D

const ACCEL =12
@export var speed = 3.5
var velocity = Vector3()
@onready var gun = $Node3D/Camera3D/gun
@onready var camera = $Node3D/Camera3D
@onready var bullet = preload("res://bullet.tscn")
@onready var raycast = $Node3D/Camera3D/RayCast3D
@onready var lives = $Node3D/lives
@onready var ammo_left = $Node3D/ammo_left
@onready var attacked = $attacked
@onready var hit = false
@onready var hurt = $Node3D/Camera3D/red
@onready var hurt_timer = $Node3D/Camera3D/red/timer2
@onready var hit_timer = $enemyattackcooldown
var mouse_visible = false

func _ready():
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		ammo_left.text = str(Globals.bullets)
		$Node3D/enemies_killed.text = str(Globals.kills)
		lives.text = str(Globals.lives)
		
func _input(event):
	if event is InputEventMouseMotion:
		$Node3D/Camera3D.rotate_x(deg_to_rad(event.relative.y * -0.3))
		$Node3D.rotate_y(deg_to_rad(event.relative.x * -0.3))
		$Node3D/Camera3D.rotation.x = clamp($Node3D/Camera3D.rotation.x, deg_to_rad(-60), deg_to_rad(80))
	elif event.is_action_pressed("ui_cancel") and mouse_visible == false:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		mouse_visible = true
		$quit.text = "Press [ESC] to resume"
	elif event.is_action_pressed("ui_cancel") and mouse_visible == true:
		$quit.text = "Press [ESC] to quit"
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		mouse_visible = false
		
	elif event.is_action_pressed("ui_up") or event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right") or event.is_action_pressed("ui_down"):
		$walk.play()
	
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_select") and Globals.bullets > 0:
		var b = bullet.instantiate()
		var bullet = get_world_3d().direct_space_state
		var collision = bullet.intersect_ray($Node3D/Camera3D/gun/Node3D.transform.origin, raycast.get_collision_point())
		$Node3D/Camera3D/gun/Node3D.add_child(b)
		b.look_at(raycast.get_collision_point(), Vector3.UP)
		gun.shoot()
		$fire.play()
		b.shoot = true
		Globals.bullets -= 1
		$Node3D/ammo_left.text = str(Globals.bullets)
		if raycast.is_colliding():
			var target = raycast.get_collider()
			if target.is_in_group("enemy") and target.hit == false:
				target.hit = true
				Globals.kills += 1
				$Node3D/enemies_killed.text = str(Globals.kills)
				checkwin()
	elif Input.is_action_just_pressed("ui_select") and Globals.bullets <= 0:
		$not_enough.show()
		$not_enough/Timer.start()
		
	var pointing = $Node3D.get_global_transform().basis
	var direction = Vector3()
		 
	if Input.is_action_pressed("ui_up"):
		direction -= pointing.z
		$AnimationPlayer.play("walk")

	elif Input.is_action_pressed("ui_down"):
		direction += pointing.z
		$AnimationPlayer.play("walk")
	
	if Input.is_action_pressed("ui_left"):
		direction -= pointing.x
		$AnimationPlayer.play("walk")
	
	elif Input.is_action_pressed("ui_right"):
		direction += pointing.x
		$AnimationPlayer.play("walk")
	
		
	if Input.is_action_just_released("ui_up"):
		$AnimationPlayer.stop(true)
		$walk.stop()
	if Input.is_action_just_released("ui_down"):
		$AnimationPlayer.stop(true)
		$walk.stop()
	if Input.is_action_just_released("ui_left"):
		$AnimationPlayer.stop(true)
		$walk.stop()
	if Input.is_action_just_released("ui_right"):
		$AnimationPlayer.stop(true)
		$walk.stop()
		
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed, ACCEL * delta)
		
	set_velocity(velocity)
	move_and_slide()
	velocity = velocity
	
func checkDead():
	if Globals.lives <= 0:
		get_tree().change_scene_to_file("res://gameover.tscn")
		
func checkwin():
	if Globals.kills == 100:
		$win.show()

func _on_Timer_timeout():
	$not_enough.hide()

func _on_timer2_timeout():
	hurt.hide()


func _on_fire_finished():
	$fire.stop()

func _on_enemyattackcooldown_timeout():
	hit = false
