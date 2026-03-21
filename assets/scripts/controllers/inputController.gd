extends Node

class_name InputController

@export var movement_controller: MovementController
@export var may_move_vertical: bool = true
var input_handler: InputHandler
var is_moving: bool = false
var is_sitting: bool = false


func _ready() -> void:
	input_handler = get_node("/root/main/input")
	if !input_handler: return
	input_handler.start_running.connect(_on_start_running)
	input_handler.stop_running.connect(_on_stop_running)
	input_handler.start_sitting.connect(_on_start_sitting)
	input_handler.jump.connect(_on_jump)


func _on_start_running() -> void:
	movement_controller.load_state("run")
	if movement_controller.has_method("set_is_running"):
		movement_controller.set_is_running(true)


func _on_stop_running() -> void:
	movement_controller.load_state("walk")
	if movement_controller.has_method("set_is_running"):
		movement_controller.set_is_running(false)


func _on_start_sitting() -> void:
	is_sitting = true
	movement_controller.load_state("sit")


func _on_jump() -> void:
	if movement_controller.has_method("jump"):
		movement_controller.jump()


func _physics_process(_delta: float) -> void:
	if input_handler.get_dir().length() > 0:
		if is_sitting:
			is_sitting = false
			movement_controller.load_state("walk")
		
		is_moving = true
		change_dir(input_handler.get_dir())
	elif is_moving:
		is_moving = false
		change_dir(Vector2.ZERO)
		movement_controller.stop.emit()


func change_dir(new_dir: Vector2) -> void:
	if !may_move_vertical:
		movement_controller.dir.x = new_dir.x
	else:
		movement_controller.dir = new_dir
