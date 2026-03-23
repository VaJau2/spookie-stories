extends Node

class_name StateMachine

@export var default_state: Node

@warning_ignore("unused_signal")
signal flip(value: bool)

var current_state: Node


func _ready() -> void:
	default_state.enable()
	current_state = default_state


func enable_state(state_name: String) -> void:
	if current_state != null:
		current_state.disable()
	
	var new_state: StateBase = get_node(state_name)
	new_state.enable()
	current_state = new_state
