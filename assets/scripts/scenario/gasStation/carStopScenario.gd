extends Node

@export_category("stopping")
@export var car_anim: AnimationPlayer
@export var land_anim: AnimationPlayer
@export var smoke: GPUParticles2D
@export var car_sound: AudioStreamPlayer2D

@export_category("starting")
@export var dir_light: DirectionalLight2D
@export var car_light: PointLight2D
@export var bowler_anim: AnimationPlayer
@export var starting_sound: AudioStream
@export var starts_count_before_dialogue: int = 3
@export var dialogue_menu: DialogueMenu

@export_category("getting out")
@export var driving_pony: Node2D
@export var spawn_point: Node2D
@export var player_prefab: PackedScene
@export var black_screen: ColorRect
@export var exit_sound: AudioStream
@export var forest_audi: AudioStreamPlayer
@export var left_obstacle: StaticBody2D


var is_stopping: bool = false
var starting_engine: bool = false


func stop() -> void:
	is_stopping = true


func try_starting() -> void:
	_stop_car()
	
	while starting_engine:
		car_sound.stream = starting_sound
		car_sound.play()
		
		if starts_count_before_dialogue > 0:
			starts_count_before_dialogue -= 1
		elif starts_count_before_dialogue == 0:
			dialogue_menu.start_dialogue("gas_station", "try_starting")
			starts_count_before_dialogue -= 1
	  	
		await car_sound.finished
		await get_tree().create_timer(randf()).timeout


func get_out_of_car() -> void:
	car_sound.stop()
	car_sound.emit_signal("finished")
	starting_engine = false
	
	while black_screen.color.a < 1:
		black_screen.color.a += 0.01
		await get_tree().process_frame
	
	driving_pony.visible = false
	_spawn_player()
	car_sound.stream = exit_sound
	car_sound.play()
	forest_audi.play()
	left_obstacle.global_position.x = spawn_point.global_position.x - 500
	
	while black_screen.color.a > 0:
		black_screen.color.a -= 0.01
		await get_tree().process_frame
	
	queue_free()



func _process(delta: float) -> void:
	if is_stopping: 
		_animate_stopping(delta)
	
	if Input.is_action_just_pressed("ui_select"):
		if starting_engine and starts_count_before_dialogue > 0 and starts_count_before_dialogue < 2:
			starts_count_before_dialogue = -1
			dialogue_menu.start_dialogue("gas_station", "try_starting")


func _animate_stopping(delta: float) -> void:
	if car_anim.speed_scale > 0.1:
		car_anim.speed_scale -= delta
	else:
		car_anim.stop()
		car_light.visible = false
	
	if car_sound.volume_linear > 0.1:
		car_sound.volume_linear -= delta
	else:
		car_sound.stop()
	
	if land_anim.speed_scale > 0.1:
		land_anim.speed_scale -= delta
	else:
		land_anim.pause()
	
	if smoke.amount > 1:
		smoke.amount -= 1
	else:
		smoke.emitting = false


func _stop_car() -> void:
	dir_light.speed = 2
	is_stopping = false
	starting_engine = true
	car_anim.stop()
	car_light.visible = false
	car_sound.stop()
	land_anim.pause()
	smoke.emitting = false
	bowler_anim.play("angry")
	car_sound.volume_linear = 1


func _spawn_player() -> void:
	var player: Node2D = player_prefab.instantiate()
	get_parent().add_child(player)
	player.global_position = spawn_point.global_position
	var player_camera: Camera2D = player.get_node("camera")
	player_camera.make_current()
