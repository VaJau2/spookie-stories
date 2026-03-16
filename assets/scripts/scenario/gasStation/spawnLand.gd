extends Node2D

@onready var empty: Node2D = get_node_or_null("empty")
@onready var station: Node2D = get_node_or_null("station")
@onready var wood_obstacles: Node2D = get_node_or_null("wood_obstacles")

var skip_showing_station: bool = false
var showed_station: bool = false

var show_obstacles: bool = false
var hide_obstacles: bool = false


func set_show_obstacles() -> void:
	show_obstacles = true


func set_hide_obstacles() -> void:
	hide_obstacles = true


func set_skip_showing() -> void:
	skip_showing_station = true


func _on_visibility_changed() -> void:
	if !visible:
		if station: _update_station()
		_update_obstacles()


func _update_station() -> void:
	if showed_station: return
	if empty.visible && !skip_showing_station:
		empty.visible = false
		station.visible = true
	else:
		empty.visible = true
		station.visible = false
		showed_station = true


func _update_obstacles() -> void:
	if show_obstacles:
		wood_obstacles.visible = true
		for obstacle: StaticBody2D in wood_obstacles.get_children():
			obstacle.collision_layer = 1
			obstacle.get_node("stun_area").is_active = true
		show_obstacles = false
	
	if hide_obstacles:
		wood_obstacles.visible = false
		for obstacle: StaticBody2D in wood_obstacles.get_children():
			obstacle.collision_layer = 0
			obstacle.get_node("stun_area").is_active = false
		hide_obstacles = false
