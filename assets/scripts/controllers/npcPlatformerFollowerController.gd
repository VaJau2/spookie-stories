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
var is_jumping: bool 


func _ready() -> void:
	player = get_node("../../" + player_name)
	var player_controller: PlatformerMovementController = player.get_node("platformer_movement")
	player_controller.jumping.connect(on_player_jump)
	player_controller.finish_jumping.connect(on_player_finish_jump)


func on_player_jump() -> void:
	temp_jump_pos = player.global_position


func on_player_finish_jump() -> void:
	if player.global_position.y <= parent.global_position.y:
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


func teleport_to_player() -> void:
	var temp_distance = parent.global_position.distance_to(player.global_position)
	if temp_distance > teleport_distance:
		parent.global_position = player.global_position
		is_jumping = false


func _process(_delta: float) -> void:
	if !parent.is_on_floor(): return
	
	teleport_to_player()
	
	if !is_jumping:
		go_to_point(player.global_position, follow_distance)
	else:
		if go_to_point(temp_jump_pos, 6):
			movement_controller.jump()
			is_jumping = false
