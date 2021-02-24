class_name State
extends Node

func input(event):
	pass

func update(delta):
	pass

func transition(new_state):
	get_parent().current_state = get_node(get_parent().states[new_state])
