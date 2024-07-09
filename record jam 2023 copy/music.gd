extends Node3D

@onready var playing = false

func playmusic():
	playing = true
	$AudioStreamPlayer.play()
	$AudioStreamPlayer2.play()
	
func stopmusic():
	$AudioStreamPlayer.stop()
	$AudioStreamPlayer2.stop()
