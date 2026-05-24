extends BaseMovementController

class_name RatMovementController

@onready var parent: CharacterBody2D = get_parent()


func _process(_delta: float) -> void:
	parent.velocity = dir


func _physics_process(_delta: float) -> void:
	if may_move:
		parent.move_and_slide()
