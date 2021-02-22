extends KinematicBody2D

export (int) var jump_height = 128
export (int) var jump_duration = 2
export (int) var run_speed = 100
export (int) var acceleration = 1200
export (int) var friction = 1200

var jump_speed = -get_jump_speed(jump_height, jump_duration)
var gravity = -get_gravity(jump_height, jump_duration)

var velocity = Vector2()
var jumping = false

func _physics_process(delta):
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var jump = Input.is_action_just_pressed('ui_select')

	if jump and is_on_floor():
		jumping = true
		velocity.y = jump_speed
	
	if right:
		velocity.x = Global.approach(velocity.x, run_speed, acceleration * delta)
	elif left:
		velocity.x = Global.approach(velocity.x, -run_speed, acceleration * delta)
	else:
		velocity.x = Global.approach(velocity.x, 0, friction * delta)
	
	velocity.y += gravity * delta
	
	if jumping and is_on_floor():
		jumping = false
	
	velocity = move_and_slide(velocity, Vector2(0, -1))

func get_jump_speed(height, duration):
	return (2 * height) / duration

func get_gravity(height, duration):
	return (-2 * jump_height) / (jump_duration * jump_duration)
