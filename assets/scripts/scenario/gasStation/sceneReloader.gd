extends Node

@export_category("wolf_run")
@export var nodes_to_delete: Array[Node]
@export var start_car_anim: AnimationPlayer
@export var car_stop: Node
@export var wolfs_spawner: Node
@export var player_start_run_point: Node2D
@export var dir_light: Light2D

@export_category("wolf_car")
@export var car_moving: Node
@export var station_land: Node


func _ready() -> void:
	if G.scene_vars.has("gas_station"):
		var station_var = G.scene_vars.gas_station
		if station_var == 1:
			load_wolfs_run()
		elif station_var == 2:
			load_wolfs_car()


func load_wolfs_run() -> void:
	start_car_anim.play("start")
	start_car_anim.seek(start_car_anim.current_animation_length)
	await get_tree().process_frame
	
	for node in nodes_to_delete:
		node.queue_free()
	car_stop.driving_pony.visible = false
	car_stop._stop_car()
	car_stop._move_station_land()
	car_stop._move_obstacle()
	var player = car_stop._spawn_player()
	var movement_controller = player.get_node("movement_controller")
	movement_controller.may_move = false
	call_deferred("_move_player", player)
	dir_light.finish()
	car_stop.queue_free()
	wolfs_spawner.spawn_wolfs()
	await get_tree().create_timer(2).timeout
	movement_controller.may_move = true
	wolfs_spawner.wolfs_run()


func _move_player(player: CharacterBody2D) -> void:
	player.global_position = player_start_run_point.global_position
	var anim: AnimationController = player.get_node("animation_controller")
	anim.set_flip(true)
	var camera: Camera2D = player.get_node("camera")
	camera.reset_smoothing()


func load_wolfs_car() -> void:
	for node in nodes_to_delete:
		node.queue_free()
	station_land.showed_station = true
	dir_light.finish()
	car_stop.queue_free()
	await get_tree().create_timer(2.5).timeout
	car_moving.spawn_wolfs()
	await get_tree().create_timer(1).timeout
	car_moving.make_car_movable()
