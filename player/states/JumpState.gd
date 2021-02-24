extends State

func update(delta):
	if Input.is_action_pressed("ui_left"):
		owner.velocity.x = Global.approach(owner.velocity.x, -owner.run_speed, owner.acceleration * delta)
	elif Input.is_action_pressed("ui_right"):
		owner.velocity.x = Global.approach(owner.velocity.x, owner.run_speed, owner.acceleration * delta)
	else:
		owner.velocity.x = Global.approach(owner.velocity.x, 0, owner.friction * delta)
	
	owner.velocity.y += owner.jump_gravity_max * delta
	
	if owner.velocity.y >= 0:
		emit_signal("state_finished", "FallState")
	
	if Input.is_action_just_released("ui_accept"):
		emit_signal("state_finished", "JumpCancelState")
	
	if owner.is_on_floor():
		owner.state = State.STATE_GROUNDED
