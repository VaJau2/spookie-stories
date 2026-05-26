extends Node2D

@export var clone_prefab: PackedScene
@export var ponies_parent: Node2D
@export var player: CharacterBody2D
@onready var patrol_points: Node2D = get_node("patrol_points")

@onready var corridor_area: Area2D = get_node("corridor_area")
@onready var corridor_point: Node2D = get_node("corridor_point")

var spawned_clone: Node2D


func _ready() -> void:
	corridor_area.corridor_trigger.connect(_on_corridor_trigger)


func spawn() -> void:
	spawned_clone = clone_prefab.instantiate()
	call_deferred("move_clone")


func move_clone() -> void:
	var old_position = patrol_points.global_position
	patrol_points.get_parent().remove_child(patrol_points)
	spawned_clone.add_child(patrol_points)
	patrol_points.global_position = old_position
	ponies_parent.add_child(spawned_clone)
	spawned_clone.global_position = global_position
	corridor_area.monitoring = true


func _on_corridor_trigger() -> void:
	spawned_clone.global_position = corridor_point.global_position
	var state_machine: StateMachine = spawned_clone.get_node("state_machine")
	var attack_state = state_machine.get_node("attack")
	attack_state.player = player
	state_machine.enable_state("attack")
