extends Node

@onready var parent: CharacterBody2D = get_parent()
@export var state_machine: StateMachine
@export var movement_controller: BaseMovementController

var velocity_y : float = 100


func jump() -> void:
	if !state_machine.may_move: return
	velocity_y = -200


func _process(delta: float) -> void:
	if velocity_y < 300:
		velocity_y += 700 * delta
	
	movement_controller.dir.y = velocity_y
