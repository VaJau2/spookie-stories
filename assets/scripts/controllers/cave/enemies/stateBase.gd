extends Node

class_name StateBase

@onready var state_machine: StateMachine = get_parent()
@onready var parent: CharacterBody2D = get_node("../../")


func _ready() -> void:
	set_process(false)


func disable() -> void:
	set_process(false)


func enable() -> void:
	set_process(true)


func _physics_process(_delta: float) -> void:
	if state_machine.may_move:
		parent.move_and_slide()
