extends StateBase

@export var seek_area: CloseSeekArea
var chaser: CharacterBody2D

var run_points: Array
var temp_run_point: Node2D


func _ready() -> void:
	super._ready()
	run_points = get_node("/root/main/run_points").get_children()


func enable() -> void:
	super.enable()
	chaser = seek_area.get_victim()
	temp_run_point = _get_run_point()
	
	if movement_controller is MovementController:
		movement_controller.load_state("run")
	
	if movement_controller is NavigationMovementController:
		movement_controller.came_to_point.connect(_on_came_to_point)


func disable() -> void:
	super.disable()
	if movement_controller is NavigationMovementController:
		if movement_controller.came_to_point.is_connected(_on_came_to_point):
			movement_controller.came_to_point.disconnect(_on_came_to_point)


func _process(_delta: float) -> void:
	if chaser == null:
		state_machine.enable_state("idle")
		return
	
	if movement_controller is NavigationMovementController:
		movement_controller.set_target(temp_run_point.global_position)


func _on_came_to_point(_delta: float) -> void:
	temp_run_point = _get_run_point()


func _get_run_point() -> Node2D:
	var farest_point: Node2D = run_points[0]
	var farest_distance = chaser.global_position.distance_to(run_points[0].global_position)
	
	for i in range(len(run_points)):
		if i == 0: continue
		var temp_distance = chaser.global_position.distance_to(run_points[i].global_position)
		if temp_distance > farest_distance:
			farest_point = run_points[i]
			farest_distance = temp_distance
	
	return farest_point
