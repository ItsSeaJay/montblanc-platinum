extends KinematicBody2D

export (int) var run_speed = 100
export (int) var jump_speed = -400
export (int) var gravity = 1200
export (int) var acceleration = 1200
export (int) var friction = 1200

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
