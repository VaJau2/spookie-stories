extends Node

@export var player_node: Node2D
@export var dialogue_menu: DialogueMenu
@export var ponies_parent: Node2D
@export var prefabs: Array[PackedScene]
@export var spawn_points: Array[Node2D]
@export var pie_dialogues: Array[DialogueArea]
@export var pie_dialogue_code: String
@export var ponies_counter: Node

@export var start_timer: float = 15

var stop_counting: bool = false


func _ready() -> void:
	set_process(false)


func start_count() -> void:
	set_process(true)


func _start_dialogue() -> void:
	var controller: MovementController = player_node.get_node("movement_controller")
	controller.set_may_move(false)
	dialogue_menu.start_dialogue("dusk_city", "lab_event")
	dialogue_menu.finished_dialogue.connect(_on_finished_dialogue)
	set_process(false)


func _on_finished_dialogue() -> void:
	var controller: MovementController = player_node.get_node("movement_controller")
	controller.set_may_move(true)
	change_pie_dialogues()
	ponies_counter.start_count()
	queue_free()


func _process(delta: float) -> void:
	if !dialogue_menu.visible && !stop_counting:
		if start_timer > 0:
			start_timer -= delta
		else:
			_start_dialogue()


func spawn_booped_scientists() -> void:
	for i in range(len(prefabs)):
		var instance = prefabs[i].instantiate()
		var patrol_points = spawn_points[i].get_node("patrol_points")
		var old_pos = patrol_points.global_position
		patrol_points.get_parent().remove_child(patrol_points)
		instance.add_child(patrol_points)
		patrol_points.global_position = old_pos
		ponies_parent.add_child(instance)
		call_deferred("move_instance_to_point", instance, spawn_points[i])


func move_instance_to_point(instance: Node2D, point: Node2D) -> void:
	instance.global_position = point.global_position


func _on_stop_count_area_body_entered(body: Node2D) -> void:
	if body == player_node:
		stop_counting = true


func _on_stop_count_area_body_exited(body: Node2D) -> void:
	if body == player_node:
		stop_counting = false


func change_pie_dialogues() -> void:
	for dialogue in pie_dialogues:
		dialogue.is_active = true
		dialogue.dialogue_code = pie_dialogue_code
