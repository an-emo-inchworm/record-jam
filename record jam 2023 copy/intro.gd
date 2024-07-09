extends Node2D

var count = 0

func _ready():
	$AudioStreamPlayer.play()
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		if count == 0:
			$"2".show()
			count += 1
		elif count == 1:
			$"3".show()
			count += 1
		elif count == 2:
			$"4".show()
			$AudioStreamPlayer2.play()
			count += 1
		elif count == 3:
			$AudioStreamPlayer2.stop()
			$"5".show()
			count += 1
		elif count == 4:
			$"6".show()
			$AudioStreamPlayer.stop()
			$AudioStreamPlayer3.play()
			count += 1
		elif count == 5:
			$"7".show()
			count += 1
		elif count == 6:
			$"8".show()
			count += 1
		elif count == 7:
			$"9".show()
			count += 1
		else:
			get_tree().change_scene_to_file("res://tutorial.tscn")
	
