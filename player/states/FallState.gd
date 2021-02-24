extends State

func enter():
	# NOTE: If we don't reset vertical momentum upon entering this state,
	#       the player will have a lot of unspent momentum from when they were
	#       colliding with the ground and falling off ledges won't feel right.
	owner.velocity.y = 0

func update(delta):
	if Input.is_action_pressed("ui_left"):
		owner.velocity.x = Global.approach(owner.velocity.x, -owner.run_speed, owner.acceleration * delta)
	elif Input.is_action_pressed("ui_right"):
		owner.velocity.x = Global.approach(owner.velocity.x, owner.run_speed, owner.acceleration * delta)
	else:
		owner.velocity.x = Global.approach(owner.velocity.x, 0, owner.friction * delta)
	
	owner.velocity.y += owner.fall_gravity * delta
	
	if owner.is_on_floor():
		if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
			emit_signal("state_finished", "RunState")
		else:
			emit_signal("state_finished", "IdleState")
