extends Node

class_name StateBase

@onready var state_machine: StateMachine = get_parent()
@onready var parent: CharacterBody2D = get_node("../../")
@onready var movement_controller: BaseMovementController = state_machine.movement_controller


func _ready() -> void:
	set_process(false)


func disable() -> void:
	set_process(false)


func enable() -> void:
	set_process(true)
