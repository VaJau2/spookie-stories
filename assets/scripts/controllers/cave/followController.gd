extends Node

class_name FollowController

@onready var parent: CharacterBody2D = get_parent()
@export var nav_controller: NavigationMovementController
@export var follow_distance: float = 4

var target: Node2D

func set_target(new_target: Node2D) -> void:
	target = new_target
	set_process(true)

func clear_target() -> void:
	target = null
	set_process(false)
	nav_controller.stop_navigation()


func _process(_delta: float) -> void:
	if target == null:
		set_process(false)
		return
	
	if parent.global_position.distance_to(target.global_position) > follow_distance:
		nav_controller.set_target(target.global_position)
