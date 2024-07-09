extends Node3D

@export var time = 10
@export var maxenemies = 5

var enemy = preload("res://enemy.tscn")
var num = 0
@export var chasespeed = 200

func _ready():
	$Timer.start(time)
	
func _on_Timer_timeout():
	if get_child_count() < maxenemies:
		var newenemy = enemy.instantiate()
		newenemy.chasespeed = chasespeed
		#newenemy.global_transform.origin.x = $node.translation.x
		#newenemy.global_transform.origin.y = $node.translation.y
		#newenemy.global_transform.origin.z = $node.translation.z
		add_child(newenemy)
			
	
