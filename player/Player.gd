extends KinematicBody2D

enum State {
	STATE_GROUNDED,
	STATE_JUMP,
	STATE_JUMP_CANCEL,
	STATE_FALL,
}

export (int) var jump_height = 128
export (int) var jump_ascend_distance = 128
export (int) var jump_descend_distance = 64

export (int) var run_speed = 128
export (int) var acceleration = 2048
export (int) var friction = 2048

var jump_duration = 2
var jump_speed = -get_jump_speed(jump_height, run_speed, jump_ascend_distance)
var jump_gravity_min = -get_gravity(jump_height / 4, run_speed, jump_ascend_distance / 4)
var jump_gravity_max = -get_gravity(jump_height, run_speed, jump_ascend_distance)
var fall_gravity = -get_gravity(jump_height, run_speed, jump_descend_distance)

var velocity = Vector2()
var jumping = false

var state = State.STATE_GROUNDED

func _physics_process(delta):
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var jump = Input.is_action_just_pressed('ui_select')
	var jump_cancel = Input.is_action_just_released('ui_select')

	print(str(state))

	match(state):
		State.STATE_GROUNDED:
			if right:
				velocity.x = Global.approach(velocity.x, run_speed, acceleration * delta)
			elif left:
				velocity.x = Global.approach(velocity.x, -run_speed, acceleration * delta)
			else:
				velocity.x = Global.approach(velocity.x, 0, friction * delta)
			
			# NOTE: The player has to have gravity applied in this state to
			#       prevent erratic state behavior
			velocity.y += fall_gravity * delta
			
			if is_on_floor():
				if jump:
					velocity.y = jump_speed
					state = State.STATE_JUMP
			else:
				state = State.STATE_FALL
		State.STATE_JUMP:
			if right:
				velocity.x = Global.approach(velocity.x, run_speed, acceleration * delta)
			elif left:
				velocity.x = Global.approach(velocity.x, -run_speed, acceleration * delta)
			else:
				velocity.x = Global.approach(velocity.x, 0, friction * delta)
			
			velocity.y += jump_gravity_max * delta
			
			if velocity.y >= 0:
				state = State.STATE_FALL
			
			if jump_cancel:
				state = State.STATE_JUMP_CANCEL
			
			if is_on_floor():
				state = State.STATE_GROUNDED
		State.STATE_JUMP_CANCEL:
			if right:
				velocity.x = Global.approach(velocity.x, run_speed, acceleration * delta)
			elif left:
				velocity.x = Global.approach(velocity.x, -run_speed, acceleration * delta)
			else:
				velocity.x = Global.approach(velocity.x, 0, friction * delta)
			
			velocity.y += jump_gravity_min * delta
			
			if velocity.y >= 0:
				state = State.STATE_FALL
			
			if is_on_floor():
				state = State.STATE_GROUNDED
		State.STATE_FALL:
			velocity.y += fall_gravity * delta
			
			if is_on_floor():
				state = State.STATE_GROUNDED
	
	velocity = move_and_slide(velocity, Vector2.UP)

func get_jump_speed(height, speed, distance):
	return (2 * height * speed) / distance

func get_gravity(height, speed, distance):
	return (-2 * height * (speed * speed)) / (distance * distance)
