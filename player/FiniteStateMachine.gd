class_name FiniteStateMachine
extends Node

export(NodePath) var start_state

var states = {}
var _current_state

func _ready():
	for child in get_children():
		if child is State:
			states[child.name] = child
			states[child.name].connect("state_finished", self, "_on_state_finished")
	
	_current_state = get_node(start_state)

func _input(event):
	if _current_state.has_method("handle_input"):
		_current_state.handle_input(event)

func _physics_process(delta):
	if _current_state.has_method("handle_update"):
		_current_state.handle_update(delta)

func change_state(new_state):
	_current_state = states[new_state]

func _on_state_finished(new_state):
	change_state(new_state)
