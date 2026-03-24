extends Node

class_name StateMachine

@export var default_state: Node

@warning_ignore("unused_signal")
signal flip(value: bool)

var current_state: Node
var may_move: bool = true

var dialogue_menu: DialogueMenu


func _ready() -> void:
	default_state.enable()
	current_state = default_state
	
	if !dialogue_menu: return
	dialogue_menu.started_dialogue.connect(_on_started_dialogue)
	dialogue_menu.finished_dialogue.connect(_on_finished_dialogue)


func enable_state(state_name: String) -> void:
	if current_state != null:
		current_state.disable()
	
	var new_state: StateBase = get_node(state_name)
	new_state.enable()
	current_state = new_state


func _on_started_dialogue() -> void:
	may_move = false


func _on_finished_dialogue() -> void:
	may_move = true
