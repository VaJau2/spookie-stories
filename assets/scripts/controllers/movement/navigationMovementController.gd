extends MovementController

class_name NavigationMovementController

#----------------------------------------------
# Отвечает за передвижение персонажа через навигацию
#-----------------------------------------------

const DEFAULT_CAME_DISTANCE: float = 20

@export var nav_agent: NavigationAgent2D
var loading_cooldown: float = 1

signal came_to_point(delta: float)


func _physics_process(delta: float) -> void:
	if loading_cooldown > 0:
		loading_cooldown -= delta
		return
	
	if !nav_agent.is_target_reachable() or nav_agent.is_navigation_finished():
		set_velocity(Vector2.ZERO)
		set_physics_process(false)
		
		if !nav_agent.is_target_reachable():
			print(parent.name + " cant reach the target")
			set_target(nav_agent.target_position)
		
		if nav_agent.is_navigation_finished():
			came_to_point.emit(delta)
		
		return
	
	var current_pos: Vector2 = parent.global_position
	var next_pos: Vector2 = nav_agent.get_next_path_position()
	dir = current_pos.direction_to(next_pos)
	
	super(delta)


func reset_came_distance() -> void:
	nav_agent.target_desired_distance = DEFAULT_CAME_DISTANCE


func set_came_distance(distance: float) -> void:
	nav_agent.target_desired_distance = distance


func set_target(new_target: Vector2) -> void:
	nav_agent.target_position = new_target
	set_physics_process(true)


func is_navigating() -> bool:
	return is_physics_processing()


func stop_navigation() -> void:
	set_physics_process(false)
	stop.emit()
