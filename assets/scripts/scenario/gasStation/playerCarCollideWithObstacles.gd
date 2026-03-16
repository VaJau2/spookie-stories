extends Node

@export var car_audi2: AudioStreamPlayer2D
@export var collide_sound: AudioStream
@export var smoke_prefab: PackedScene
@export var land_anim: AnimationPlayer
@export var camera: Camera2D

var move_right_speed: float = 0


func collide(obstacle: Node2D) -> void:
	car_audi2.stream = collide_sound
	car_audi2.play()
	move_right_speed = 3
	land_anim.speed_scale = 0.5
	var smoke = smoke_prefab.instantiate()
	obstacle.get_node("../../").add_child(smoke)
	smoke.global_position = obstacle.global_position
	set_process(true)


func _ready() -> void:
	set_process(false)


func _process(delta: float) -> void:
	if land_anim.speed_scale < 1:
		land_anim.speed_scale += delta * 2
	
	if move_right_speed > 0:
		if camera.global_position.x < 100:
			camera.global_position.x += move_right_speed / 2
		get_parent().global_position.x += move_right_speed
		move_right_speed -= delta * 10
	else:
		set_process(false)
