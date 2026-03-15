extends Node2D


func _ready() -> void:
	var car_stop_scenario = get_node("/root/main/car_stop")
	car_stop_scenario.player_spawned.connect(_on_player_spawned)


func _on_player_spawned() -> void:
	visible = true
