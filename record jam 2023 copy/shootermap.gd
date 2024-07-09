extends Node3D

func _ready():
	if Music.playing == false:
		Music.playmusic()
