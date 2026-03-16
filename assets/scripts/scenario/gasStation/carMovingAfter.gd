extends Node

@export var dialogue_menu: DialogueMenu
@export var dialogue_file: String
@export var dialogue_code: String
@export var final_dialogue_code: String

@export var wolf_car_prefab: PackedScene
@export var player_car: Node2D
@export var camera: Node2D
@export var lands_to_spawn_obstacles: Array[Node2D]

var spawned_cars_count: int


func start() -> void:
	await get_tree().create_timer(2.0).timeout
	dialogue_menu.start_dialogue(dialogue_file, dialogue_code)


func spawn_wolfs() -> void:
	for i in range(3):
		var car = wolf_car_prefab.instantiate()
		call_deferred("_move_spawned_car", car, i)
		spawned_cars_count += 1
	_move_camera_back()


func make_car_movable() -> void:
	var car_controller = player_car.get_node("moving_controller")
	car_controller.set_process(true)
	for land in lands_to_spawn_obstacles:
		land.set_show_obstacles()


func delete_wolf_car() -> void:
	spawned_cars_count -= 1
	if spawned_cars_count == 0:
		for land in lands_to_spawn_obstacles:
			land.set_hide_obstacles()
		
		await get_tree().create_timer(4.0).timeout
		dialogue_menu.start_dialogue(dialogue_file, final_dialogue_code)


func _move_spawned_car(car: Node2D, index: int) -> void:
	get_parent().add_child(car)
	car.scenario = self
	car.player_car = player_car
	car.name = "wolf_car" + str(index)
	car.global_position.x = player_car.global_position.x + 700
	car.global_position.y = randf_range(-25, 130)
	_move_wolf_car_front(car)


func _move_camera_back() -> void:
	while camera.global_position.x < 220:
		camera.global_position.x += 1
		await get_tree().process_frame


func _move_wolf_car_front(car: Node2D) -> void:
	var delta = randi_range(60, 120)
	while delta > 0:
		car.global_position.x -= 1
		delta -= 1
		await get_tree().process_frame
