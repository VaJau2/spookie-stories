extends Node

@export var dialogue_menu: DialogueMenu
@export var dialogue_file: String
@export var dialogue_code: String

@export var wolf_car_prefab: PackedScene
@export var player_car: Node2D
@export var camera: Node2D
@export var lands_to_spawn_obstacles: Array[Node2D]

var spawned_cars: Array[Node2D]


func start() -> void:
	await get_tree().create_timer(2.0).timeout
	dialogue_menu.start_dialogue(dialogue_file, dialogue_code)


func spawn_wolfs() -> void:
	for i in range(3):
		var car = wolf_car_prefab.instantiate()
		call_deferred("_move_spawned_car", car)
		spawned_cars.append(car)
	_move_camera_back()


func make_car_movable() -> void:
	var car_controller = player_car.get_node("moving_controller")
	car_controller.set_process(true)
	for land in lands_to_spawn_obstacles:
		land.set_show_obstacles()


func _move_spawned_car(car: Node2D) -> void:
	get_parent().add_child(car)
	car.global_position.x = player_car.global_position.x + 600
	car.global_position.y = randf_range(-25, 130)
	_move_wolf_car_front(car)


func _move_camera_back() -> void:
	while camera.global_position.x < 150:
		camera.global_position.x += 1
		await get_tree().process_frame


func _move_wolf_car_front(car: Node2D) -> void:
	var delta = randi_range(40, 100)
	while delta > 0:
		car.global_position.x -= 1
		delta -= 1
		await get_tree().process_frame
