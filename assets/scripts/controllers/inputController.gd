extends Node

class_name InputController

@export var movement_controller: MovementController
var input_handler: InputHandler
var is_moving: bool = false
var is_sitting: bool = false
var temp_interactable: Node


func _ready() -> void:
	input_handler = get_node("/root/main/input")
	input_handler.start_running.connect(_on_start_running)
	input_handler.stop_running.connect(_on_stop_running)
	input_handler.start_sitting.connect(_on_start_sitting)


func _on_start_running() -> void:
	movement_controller.load_state("run")


func _on_stop_running() -> void:
	movement_controller.load_state("walk")


func _on_start_sitting() -> void:
	is_sitting = true
	movement_controller.load_state("sit")


func _physics_process(_delta: float) -> void:
	if input_handler.get_dir().length() > 0:
		if is_sitting:
			is_sitting = false
			movement_controller.load_state("walk")
		
		is_moving = true
		movement_controller.set_velocity(input_handler.get_dir() * movement_controller.current_state.speed)
	elif is_moving:
		is_moving = false
		movement_controller.set_velocity(Vector2.ZERO)
