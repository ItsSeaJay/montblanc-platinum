class_name FiniteStateMachine
extends Node

export(NodePath) var start_state

var states = {}
var _current_state

func _ready():
	assert(start_state != null)
	
	for child in get_children():
		if child is State:
			states[child.name] = child
			states[child.name].connect("state_finished", self, "_on_state_finished")
			states[child.name].init()
	
	_current_state = get_node(start_state)
	_current_state.enter()

func _input(event):
	if _current_state.has_method("input"):
		_current_state.input(event)

func _process(delta):
	print(_current_state.name)

func _physics_process(delta):
	if _current_state.has_method("update"):
		_current_state.update(delta)

func change_state(new_state):
	if _current_state.has_method("exit"):
		_current_state.exit()
	
	_current_state = states[new_state]
	
	if _current_state.has_method("enter"):
		_current_state.enter()

func _on_state_finished(new_state):
	change_state(new_state)
