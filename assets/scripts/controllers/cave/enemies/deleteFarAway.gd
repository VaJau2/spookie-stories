extends Node

@onready var player: Node2D = get_node("/root/main/player")
@export var delete_distance: float
@export var die_controller: Node


func _process(_delta: float) -> void:
	var parent: Node2D = get_parent()
	var distance = parent.global_position.distance_to(player.global_position)
	if distance > delete_distance:
		die_controller.die()
