extends Node3D

@export var time = 10
@export var maxenemies = 5

var enemy = preload("res://ammo.tscn")
var num = 0

func _ready():
	$Timer.start(time)
	
func _on_Timer_timeout():
	if get_child_count() < maxenemies:
		var newenemy = enemy.instantiate()
		newenemy.global_transform.origin.x = $node.position.x
		newenemy.global_transform.origin.y = $node.position.y
		newenemy.global_transform.origin.z = $node.position.z
		add_child(newenemy)
		#num += 1
			
	
