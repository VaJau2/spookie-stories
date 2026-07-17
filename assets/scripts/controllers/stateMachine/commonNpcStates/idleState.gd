extends StateBase

var patrol_points: Array[Vector2] = []
var point_i: int = 0

var WAIT_TIME: Array[float] = [0.5, 5]
var wait_timer: float

var came_to_point: bool = false


func _ready() -> void:
	_load_patrol_points()
	if movement_controller is NavigationMovementController:
		movement_controller.came_to_point.connect(_on_came_to_point)


func enable() -> void:
	super.enable()
	if movement_controller is MovementController:
		movement_controller.load_state("walk")


func _on_came_to_point() -> void:
	came_to_point = true


func _process(delta: float) -> void:
	if len(patrol_points) == 0: return
	
	if !came_to_point: return
	
	if wait_timer > 0:
		wait_timer -= delta
		return
	
	if movement_controller is NavigationMovementController:
		movement_controller.set_target(patrol_points[point_i])
		point_i += 1
		if point_i >= len(patrol_points):
			point_i = 0
	
	came_to_point = false
	wait_timer = randf_range(WAIT_TIME[0], WAIT_TIME[1])


func _load_patrol_points() -> void:
	var points = parent.get_node_or_null("patrol_points")
	if !points: return
	
	for point: Node2D in points.get_children():
		patrol_points.append(point.global_position)
	
	points.queue_free()
