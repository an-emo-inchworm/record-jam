extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Music.stopmusic()
	Music.playing = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
