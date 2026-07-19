extends Node2D

@export var wait_time: float = 5

@onready var audi: AudioStreamPlayer2D = get_node("audi")
var idle_state: StateBase


func handle_character(state: StateBase) -> void:
	if audi: 
		audi.play()
	idle_state = state
	state.parent.visible = false
	set_process(true)


func _ready() -> void:
	set_process(false)


func _process(delta: float) -> void:
	if wait_time > 0:
		wait_time -= delta
		return
	
	if audi: audi.play()
	idle_state.set_new_target_point()
	idle_state.parent.visible = true
	set_process(false)
