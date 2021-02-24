extends KinematicBody2D

var velocity = Vector2()
var jumping = false

func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP)

func get_jump_speed(height, speed, distance):
	return (2 * height * speed) / distance

func get_gravity(height, speed, distance):
	return (-2 * height * (speed * speed)) / (distance * distance)
