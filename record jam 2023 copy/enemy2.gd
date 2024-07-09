extends Node

var speed = 0.01

enum state{
	roaming, change, colliding, chasing
}

var enemy_state = state.roaming

func _ready():
	enter_state(state.roaming)
	
func _physics_process(delta):
	process_states()
	
func enter_state(pass_state):
	if enemy_state != pass_state:
		leave_state(enemy_state)
		enemy_state = pass_state
		
	if pass_state == state.roaming:
		$Timer.start(Callable(0.5, 2))
		
func process_states():
	if enemy_state == state.roaming:
		process_roaming()
	elif enemy_state == state.colliding:
		process_colliding()
	elif enemy_state == state.chasing:
		process_chasing()
		
func process_roaming():
	pass

func process_colliding():
	pass
	
func process_chasing():
	pass
	
func leave_state(pass_state):
	pass


func _on_Area_body_entered(body):
	if body.name == "player":
		body.hurt.show()
		body.hurt_timer.start()
		Globals.lives -= 1
		body.lives.text = str(Globals.lives)
		body.checkDead()


func _on_Timer_timeout():
	enter_state(state.change)
