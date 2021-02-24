extends State

func handle_update(delta):
	print(delta)
	
	if Input.is_action_just_released("ui_accept"):
		emit_signal("state_finished", "IdleState")
