extends State

func update(delta):
	if Input.is_action_pressed("ui_left"):
		owner.velocity.x = Global.approach(owner.velocity.x, -owner.run_speed, owner.acceleration * delta)
	elif Input.is_action_pressed("ui_right"):
		owner.velocity.x = Global.approach(owner.velocity.x, owner.run_speed, owner.acceleration * delta)
	else:
		owner.velocity.x = Global.approach(owner.velocity.x, 0, owner.friction * delta)
	
	owner.velocity.y += owner.fall_gravity
	
	if owner.is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			owner.velocity.y = owner.jump_speed
			emit_signal("state_finished", "JumpState")
	else:
		emit_signal("state_finished", "FallState")
	
	if owner.velocity.x == 0:
		if not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
			emit_signal("state_finished", "IdleState")
