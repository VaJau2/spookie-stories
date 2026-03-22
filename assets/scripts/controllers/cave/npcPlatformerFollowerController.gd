extends Node

class_name NpcPlatformerFollowerController

@export var movement_controller: PlatformerMovementController
@export var player_name: String
@export var follow_distance: float
@export var run_distance: float
@export var teleport_distance: float

@onready var parent: CharacterBody2D = get_parent()

var player: CharacterBody2D
var temp_jump_pos: Vector2
var jump_poses: Array[Vector2]
var is_jumping: bool


func _ready() -> void:
	player = get_node("../../" + player_name)
	var player_controller: PlatformerMovementController = player.get_node("platformer_movement")
	player_controller.jumping.connect(on_player_jump)
	player_controller.finish_jumping.connect(on_player_finish_jump)


func on_player_jump() -> void:
	temp_jump_pos = player.global_position


func on_player_finish_jump() -> void:
	if temp_jump_pos == Vector2.ZERO: return
	jump_poses.append(temp_jump_pos)
	temp_jump_pos = Vector2.ZERO
	is_jumping = true


func go_to_point(point: Vector2, distance: float) -> bool:
	var temp_distance_x = abs(parent.global_position.x - point.x)
	if temp_distance_x > run_distance:
		if !movement_controller.is_running:
			movement_controller.load_state("run")
			movement_controller.set_is_running(true)
	else:
		if movement_controller.is_running:
			movement_controller.load_state("default")
			movement_controller.set_is_running(false)
		
	if temp_distance_x > distance:
		if parent.global_position.x > point.x:
			movement_controller.dir.x = -1
		else:
			movement_controller.dir.x = 1
		return false
	else:
		movement_controller.dir = Vector2.ZERO
		return true


func teleport_to_player() -> bool:
	var temp_distance = parent.global_position.distance_to(player.global_position)
	if temp_distance > teleport_distance:
		is_jumping = false
		temp_jump_pos = Vector2.ZERO 
		parent.global_position = player.global_position
		jump_poses.clear()
		movement_controller.dir = Vector2.ZERO
		return true
	return false


func _process(_delta: float) -> void:
	if !parent.is_on_floor(): return
	if teleport_to_player(): return
	
	if !is_jumping:
		if temp_jump_pos != Vector2.ZERO:
			go_to_point(temp_jump_pos, follow_distance)
		else:
			go_to_point(player.global_position, follow_distance)
	else:
		if len(jump_poses) == 0:
			is_jumping = false
			return
		
		if go_to_point(jump_poses[0], 6):
			movement_controller.jump()
			jump_poses.remove_at(0)
			if len(jump_poses) <= 0:
				is_jumping = false
