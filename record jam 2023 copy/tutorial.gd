extends Node3D

var count = 0

func _ready():
	$Label.show()
	$enter.show()
	$AudioStreamPlayer.play()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if count == 0:
			$Label.text = "Left click to shoot in the direction of the cross hair." 
			count += 1
		elif count == 1:
			$Label.text = "Collect 100 souls and bring them back to me to win."
			count += 1
		elif count == 2:
			$Label.text ="You may carry up to 20 bullets. collect ammo packs to refill."
			count += 1
		elif count == 3:
			$Label.text = "You have 3 lives, collect hearts to heal."
			count += 1
		elif count == 4:
			$Label.text = "Good luck."
			count += 1
		else:
			$Label.hide()
			$enter.hide()

