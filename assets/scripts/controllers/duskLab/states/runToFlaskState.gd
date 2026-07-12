extends StateBase

@onready var animation_controller: AnimationController = get_node("../../animation_controller")
@export var flip_h: bool

var flask_pos: Vector2
var check_flip: bool


func _ready() -> void:
	flask_pos = get_node("../../flask_point").global_position


func enable() -> void:
	super.enable()
	
	if movement_controller is MovementController:
		movement_controller.load_state("run")
	
	if movement_controller is NavigationMovementController:
		movement_controller.set_target(flask_pos)
		movement_controller.came_to_point.connect(_on_came_to_point)


func _on_came_to_point() -> void:
	animation_controller.set_flip(flip_h)
	movement_controller.came_to_point.disconnect(_on_came_to_point)
