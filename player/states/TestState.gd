extends State

func update(delta):
	print(delta)
	
	if Input.is_action_just_released("ui_accept"):
		transition("IdleState")
