extends State

func handle_update(delta):
	print(delta * 2)
	
	if Input.is_action_just_released("ui_accept"):
		emit_signal("state_finished", "TestState")
