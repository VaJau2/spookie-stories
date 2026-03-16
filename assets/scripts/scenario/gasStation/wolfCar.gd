extends CharacterBody2D

@export var car_audi: AudioStreamPlayer2D
@export var collide_sound: AudioStream

var scenario: Node

var crashes_count: int = 7
var move_right_speed: float = 0

var player_car: Node2D

var follow_speed: float
var follow_distance: float


func collide() -> void:
	car_audi.stream = collide_sound
	car_audi.play()
	move_right_speed = 2
	if crashes_count > 0:
		crashes_count -= 1
	else:
		move_right_speed = 6


func _follow_player(delta: float) -> void:
	var dir: float = 0
	var player_y = player_car.global_position.y
	
	if global_position.y > player_y + follow_distance: 
		dir = -follow_speed
	elif global_position.y < player_y - follow_distance:
		dir = follow_speed
	
	if dir != 0:
		global_position.y += dir * delta


func _ready() -> void:
	follow_speed = randf_range(10, 100)
	follow_distance = randf_range(5, 40)


func _process(delta: float) -> void:
	if move_right_speed > 0:
		global_position.x += move_right_speed
		move_right_speed -= delta * 10 if crashes_count > 0 else delta * 2
	elif crashes_count == 0:
		scenario.delete_wolf_car()
		queue_free()
		return
	
	_follow_player(delta)
