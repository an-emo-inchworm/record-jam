extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.lives = 3
	Globals.kills = 0
	Globals.bullets = 20
	Music.stopmusic()
	Music.playing = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://shootermap.tscn")
		
