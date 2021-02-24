extends KinematicBody2D

export (int) var jump_height_min = 32
export (int) var jump_height_max = 128
export (int) var jump_ascend_distance = 128
export (int) var jump_descend_distance = 64

export (int) var run_speed = 128
export (int) var acceleration = 512
export (int) var friction = 512

var jump_duration = 2
var jump_speed = -get_jump_speed(jump_height_min, run_speed, jump_ascend_distance)
var jump_gravity_min = -get_gravity(jump_height_min, run_speed, jump_ascend_distance)
var jump_gravity_max = -get_gravity(jump_height_max, run_speed, jump_ascend_distance)
var fall_gravity = -get_gravity(jump_height_max, run_speed, jump_descend_distance)

var gravity = jump_gravity_min

var velocity = Vector2()
var jumping = false

func _ready():
	print(get_gravity(32, run_speed, jump_ascend_distance))

func _physics_process(delta):
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var jump = Input.is_action_just_pressed('ui_select')
	var jump_cancel = Input.is_action_just_released('ui_select')

	if jump and is_on_floor():
		velocity.y = jump_speed
		gravity = jump_gravity_max
	
	if right:
		velocity.x = Global.approach(velocity.x, run_speed, acceleration * delta)
	elif left:
		velocity.x = Global.approach(velocity.x, -run_speed, acceleration * delta)
	else:
		velocity.x = Global.approach(velocity.x, 0, friction * delta)
	
	if not is_on_floor():
		if velocity.y > 0:
			gravity = fall_gravity
	
	velocity.y += gravity * delta
	
	velocity = move_and_slide(velocity, Vector2.UP)

func get_jump_speed(height, speed, distance):
	return (2 * height * speed) / distance

func get_gravity(height, speed, distance):
	return (-2 * height * (speed * speed)) / (distance * distance)
