extends Node

@export var movement_controller: PlatformerMovementController
@export var jump_controller: Node
@export var check_time: float = 0.2
@onready var parent: CharacterBody2D = get_parent()

var check_pos_start: Vector2
var check_start: bool = true

var check_timer: float


func _process(delta: float) -> void:
	if movement_controller:
		if movement_controller.dir.length() <= 0:
			return
	else:
		if parent.velocity.length() < 5:
			return
		
	if check_timer > 0:
		check_timer -= delta
	else:
		check_timer = check_time
		
		if check_start:
			check_pos_start = parent.global_position
		else:
			var check_pos_end = parent.global_position
			if check_pos_start == check_pos_end:
				if movement_controller:
					movement_controller.jump()
				else:
					jump_controller.jump()
		
		check_start = !check_start
