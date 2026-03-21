extends Node

class_name MovementController

#----------------------------------------------
# Отвечает за передвижение персонажа
#-----------------------------------------------

@onready var parent: CharacterBody2D = get_parent()

var may_move: bool = true
var dir: Vector2
var current_state: MovementState

signal move
signal stop
signal state_changed(state: String)


func _ready() -> void:
	load_state('default')


func set_may_move(value: bool) -> void:
	may_move = value
	if !may_move:
		stop.emit()


func _physics_process(_delta: float) -> void:
	if !may_move: return
	set_velocity(dir * current_state.speed)
	parent.move_and_slide()


func load_state(state_name: String = 'default') -> void:
	if current_state != null and state_name == current_state.name: return
	
	if state_name == 'default':
		for state in get_children():
			if state is MovementState and state.default:
				set_current_state(state)
	else:
		var new_state = get_node_or_null(state_name)
		if new_state:
			set_current_state(get_node(state_name))


func set_current_state(new_state: MovementState) -> void:
	current_state = new_state
	state_changed.emit(new_state.name)


func set_velocity(new_velocity: Vector2) -> void:
	if parent.velocity == new_velocity: return
	parent.velocity = new_velocity
	emit_move_signals()


func emit_move_signals() -> void:
	if parent.velocity.length() > 0:
		move.emit()
	else:
		stop.emit()
