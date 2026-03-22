extends Node

@export var movement_controller: PlatformerMovementController
@onready var parent: Node2D = get_parent()

var check_pos_start: Vector2
var check_start: bool = true

var check_timer: float
const CHECK_TIME: float = 0.2


func _process(delta: float) -> void:
	if movement_controller.dir.length() == 0:
		return
		
	if check_timer > 0:
		check_timer -= delta
	else:
		check_timer = CHECK_TIME
		
		if check_start:
			check_pos_start = parent.global_position
		else:
			var check_pos_end = parent.global_position
			if check_pos_start == check_pos_end:
				movement_controller.jump()
		
		check_start = !check_start
