extends StateBase

var patrol_points: Array[Node2D]
var point_i: int = 0

var WAIT_TIME: Array[float] = [0.5, 5]
var wait_timer: float

var temp_target_point: Node2D
var came_to_point: bool = false


func _ready() -> void:
	_load_patrol_points()
	set_new_target_point()
	if movement_controller is NavigationMovementController:
		movement_controller.came_to_point.connect(_on_came_to_point)


func _process(delta: float) -> void:
	if len(patrol_points) == 0: return
	
	if !came_to_point: return
	if wait_timer > 0:
		wait_timer -= delta
		return
	
	set_new_target_point()


func _load_patrol_points() -> void:
	var points: Node2D = parent.get_node_or_null("patrol_points")
	if !points: return
	
	var old_position = points.global_position
	points.top_level = true
	points.global_position = old_position
	
	for point: Node2D in points.get_children():
		patrol_points.append(point)


func _change_patrol_points_child(points: Node) -> void:
	parent.remove_child(points)
	var ponies_parent: Node = parent.get_parent()
	ponies_parent.add_child(points)


func enable() -> void:
	super.enable()
	if movement_controller is MovementController:
		movement_controller.load_state("walk")


func _on_came_to_point() -> void:
	if !temp_target_point: return
	
	if temp_target_point.has_method("handle_character"):
		temp_target_point.handle_character(self)
		return
	
	wait_timer = randf_range(WAIT_TIME[0], WAIT_TIME[1])	
	came_to_point = true


func set_new_target_point() -> void:
	temp_target_point = patrol_points[point_i]
	
	if movement_controller is NavigationMovementController:
		movement_controller.set_target(temp_target_point.global_position)
	
	point_i += 1
	if point_i >= len(patrol_points):
		point_i = 0
		
	came_to_point = false
