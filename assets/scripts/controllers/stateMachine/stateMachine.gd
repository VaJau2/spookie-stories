extends Node

class_name StateMachine

@export var default_state: StateBase
@export var movement_controller: BaseMovementController

@warning_ignore("unused_signal")
signal flip(value: bool)

signal state_changed(new_state: String)

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
	state_changed.emit(state_name)


func _on_started_dialogue() -> void:
	may_move = false


func _on_finished_dialogue() -> void:
	may_move = true
