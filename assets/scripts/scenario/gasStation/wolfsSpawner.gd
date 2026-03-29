extends Node

@export var wolf_prefab: PackedScene
@export var spawn_points: Array[Node2D]
@export var obstacles: Node2D
@export var player_name: String
@export var growl_sound: AudioStream
@export var sit_dialogue: DialogueArea
var spawned_wolfs: Array[CharacterBody2D]


func spawn_wolfs() -> void:
	G.scene_vars.set("gas_station", 1)
	
	for index in range(len(spawn_points)):
		var point = spawn_points[index]
		var walk_point = point.get_node("walk")
		var wolf: CharacterBody2D = wolf_prefab.instantiate()
		spawned_wolfs.append(wolf)
		call_deferred("set_wolf_walk_point", wolf, point, walk_point)
	
	obstacles.visible = true
	for obstacle: StaticBody2D in obstacles.get_children():
		obstacle.collision_layer = 1
		obstacle.get_node("stun_area").is_active = true


func set_wolf_walk_point(wolf: CharacterBody2D, point: Node2D, walk_point: Node2D) -> void:
	get_parent().add_child(wolf)
	wolf.global_position = point.global_position
	var wolf_controller: NavigationMovementController = wolf.get_node("movement_controller")
	wolf_controller.set_target(walk_point.global_position)
	var audi: AudioStreamPlayer2D = wolf.get_node("audi")
	audi.stream = growl_sound
	audi.play()


func wolfs_run() -> void:
	await get_tree().create_timer(1.0).timeout
	for wolf in spawned_wolfs:
		var audi: AudioStreamPlayer2D = wolf.get_node("audi")
		audi.play_run_sound = true
		var wolf_controller: NavigationMovementController = wolf.get_node("movement_controller")
		wolf_controller.load_state("run")
		var wolf_follow: FollowController = wolf.get_node("follow_controller")
		var player = get_parent().get_node(player_name)
		wolf_follow.set_target(player)
	sit_dialogue.is_active = true


func delete_wolfs() -> void:
	for index in range(len(spawned_wolfs)):
		var wolf = spawned_wolfs[index]
		var wolf_follow: FollowController = wolf.get_node("follow_controller")
		wolf_follow.clear_target()
		var wolf_controller: NavigationMovementController = wolf.get_node("movement_controller")
		wolf_controller.set_target(spawn_points[index].global_position)
	
	await get_tree().create_timer(1).timeout
	
	for wolf in spawned_wolfs:
		wolf.queue_free()
