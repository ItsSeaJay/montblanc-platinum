class_name FiniteStateMachine
extends Node

export(NodePath) var start_state

var states = {}
var current_state

func _ready():
	for child in get_children():
		if child is State:
			states[child.name] = child.get_path()
	
	current_state = get_node(start_state)

func _input(event):
	current_state.input(event)

func _physics_process(delta):
	current_state.update(delta)
