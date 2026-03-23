extends Node2D

@onready var player: Node2D = get_node("/root/main/player")
@onready var parent: RatSpawnersManager = get_parent()

const CHECK_TIME: Array = [5, 10]
var timer: float


func _ready() -> void:
	timer = randf_range(CHECK_TIME[0], CHECK_TIME[1])


func _process(delta: float) -> void:
	if timer > 0:
		timer -= delta
		return
	
	var distance = get_parent().global_position.distance_to(player.global_position)
	if distance > parent.spawn_distance && distance < parent.max_spawn_distance:
		_spawn_rat()
	
	timer = randf_range(CHECK_TIME[0], CHECK_TIME[1])


func _spawn_rat() -> void:
	var rat_prefab = parent.rat_prefabs[randi() % len(parent.rat_prefabs)]
	var rat = rat_prefab.instantiate()
	rat.get_node("die_controller").manager = parent
	call_deferred("_move_spawned_rat", rat)


func _move_spawned_rat(rat: Node2D) -> void:
	var rat_parent = player.get_parent()
	rat_parent.add_child(rat)
	rat.global_position = global_position
