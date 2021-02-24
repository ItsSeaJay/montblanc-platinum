extends State

func update(delta):
	print(delta * 2)
	
	if Input.is_action_just_released("ui_accept"):
		transition("TestState")
