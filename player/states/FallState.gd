extends State

func update(delta):
	if Input.is_action_pressed("ui_left"):
		owner.velocity.x = Global.approach(owner.velocity.x, -owner.run_speed, owner.acceleration * delta)
	elif Input.is_action_pressed("ui_right"):
		owner.velocity.x = Global.approach(owner.velocity.x, owner.run_speed, owner.acceleration * delta)
	else:
		owner.velocity.x = Global.approach(owner.velocity.x, 0, owner.friction * delta)
	
	owner.velocity.y += owner.fall_gravity * delta
	
	if owner.is_on_floor():
		emit_signal("state_finished", "IdleState")
