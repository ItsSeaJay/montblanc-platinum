extends State

func update(delta):
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		emit_signal("state_finished", "RunState")
	
	owner.velocity.x = 0
	owner.velocity.y += owner.fall_gravity
	
	if owner.is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			owner.velocity.y = owner.jump_speed
			emit_signal("state_finished", "JumpState")
	else:
		emit_signal("state_finished", "FallState")
