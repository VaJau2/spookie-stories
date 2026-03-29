extends Node

@export var car_camera: Camera2D
@export var player_name: String
@export var driving_pony: Node2D
@export var bowler_anim: AnimationPlayer
@export var starting_sound: AudioStream
@export var car_sound: AudioStream

@export var car_anim: AnimationPlayer
@export var land_anim: AnimationPlayer
@export var smoke: GPUParticles2D
@export var car_audi: AudioStreamPlayer2D
@export var car_audi2: AudioStreamPlayer2D
@export var car_light: PointLight2D
@export var station_land: Node2D

@export var car_moving: Node

var load_starting: bool
var load_starting_timer: float = 2.0
var is_starting: bool


func start() -> void:
	station_land.showed_station = true
	var player = get_node("/root/main/" + player_name)
	player.queue_free()
	car_camera.make_current()
	driving_pony.visible = true
	car_light.visible = true
	car_audi.stream = car_sound
	car_audi2.stream = starting_sound
	car_audi2.play()
	smoke.emitting = true
	bowler_anim.play("idle")
	load_starting = true
	set_process(true)


func move() -> void:
	G.scene_vars.set("gas_station", 2)
	_finish_starting()
	car_moving.start()


func _animate_starting(delta: float) -> void:
	if car_anim.speed_scale < 1:
		car_anim.speed_scale += delta
	
	if car_audi2.volume_linear > 0.1:
		car_audi2.volume_linear -= delta
	else:
		car_audi2.stop()
	
	if car_audi.volume_linear < 1:
		car_audi.volume_linear += delta
	
	if land_anim.speed_scale < 1:
		land_anim.speed_scale += delta
	
	if smoke.amount < 42:
		smoke.amount += 1


func _finish_starting() -> void:
	car_audi.play()
	car_anim.play()
	land_anim.play()
	load_starting = false
	is_starting = false
	car_anim.speed_scale = 1
	car_audi.volume_linear = 1
	car_audi2.volume_linear = 1
	land_anim.speed_scale = 1
	smoke.amount = 42
	smoke.restart()
	car_audi2.stop()
	set_process(false)


func _ready() -> void:
	set_process(false)


func _process(delta: float) -> void:
	if load_starting:
		if load_starting_timer > 0:
			load_starting_timer -= delta
		else:
			car_audi.play()
			car_anim.speed_scale = 0.1
			car_anim.play()
			land_anim.speed_scale = 0.1
			land_anim.play()
			smoke.restart()
			load_starting = false
			is_starting = true
	
	if is_starting:
		_animate_starting(delta)
