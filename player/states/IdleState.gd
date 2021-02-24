extends State

export(int) var jump_height = 128
export(int) var jump_distance = 64
export(int) var move_speed = 128
export(int) var acceleration = 2048
export(int) var friction = 2048

onready var gravity = -owner.get_gravity(jump_height, move_speed, jump_distance)
onready var jump_speed = -owner.get_jump_speed(jump_height, move_speed, jump_distance)

func update(delta):
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		emit_signal("state_finished", "RunState")
	
	owner.velocity.y += gravity * delta
	
	if owner.is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			owner.velocity.y = jump_speed
			emit_signal("state_finished", "JumpState")
	else:
		emit_signal("state_finished", "FallState")
