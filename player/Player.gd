extends KinematicBody2D

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

func _physics_process(delta):	
	velocity = move_and_slide(velocity, Vector2.UP)

func get_jump_speed(height, speed, distance):
	return (2 * height * speed) / distance

func get_gravity(height, speed, distance):
	return (-2 * height * (speed * speed)) / (distance * distance)
