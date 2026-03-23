extends Node2D

class_name RevolverController

@export var moving_controller: MovementController
@export var animation_controller: AnimationController
@export var pony_sprite: Sprite2D
@export var gun: Sprite2D
@export var shoot_sound: AudioStream
@export var gun_off_sound: AudioStream
@export var miss_sound: AudioStream
@export var no_ammo_sound: AudioStream
@export var take_ammo_sound: AudioStream
@export var explosion_sounds: Array[AudioStream]

@onready var explosion_back: ColorRect = get_node("/root/main/menu/explosion")
@onready var audi: AudioStreamPlayer2D = get_node("audi")
@onready var miss_audi: AudioStreamPlayer2D = get_node("miss_audi")
@onready var raycast: RayCast2D = get_node("raycast")
@onready var light: PointLight2D = get_node("light")
@onready var light_left_pos: Node2D = get_node("light_pos_l")
@onready var light_right_pos: Node2D = get_node("light_pos_r")
@onready var effect_left: Node2D = get_node("effect_l")
@onready var effect_right: Node2D = get_node("effect_r")

var ammo_count: int = 6

var input_handler: InputHandler

var show_gun_timer: float
const SHOW_GUN_TIME: float = 2

var show_light_timer: float
var SHOW_LIGHT_TIME: float = 0.1

var cooldown_timer: float
var COOLDOWN_TIME: float = 0.5

signal shoot
signal ammo_changed(new_value: int)


func add_ammo(count: int) -> void:
	ammo_count += count
	ammo_changed.emit(ammo_count)
	audi.stream = take_ammo_sound
	audi.play()


func _ready() -> void:
	input_handler = get_node("/root/main/input")
	if !input_handler: return
	input_handler.shoot.connect(_on_shoot)


func _process(delta: float) -> void:
	if !moving_controller.may_move: return
	
	if cooldown_timer > 0:
		cooldown_timer -= delta
	
	if gun.visible:
		if show_gun_timer > 0:
			show_gun_timer -= delta
		else:
			gun.visible = false
			audi.stream = gun_off_sound
			audi.play()
	
	if light.visible:
		if show_light_timer > 0:
			show_light_timer -= delta
		else:
			if light.energy > 0:
				light.energy -= 5 * delta
			else:
				light.visible = false


func _on_shoot(pos: Vector2) -> void:
	if ammo_count <= 0: 
		audi.stream = no_ammo_sound
		audi.play()
		return
	
	if cooldown_timer > 0: return
	audi.stream = shoot_sound
	audi.play()
	show_gun_timer = SHOW_GUN_TIME
	gun.visible = true
	animation_controller.set_flip(pos.x > global_position.x)
	set_light_on()
	show_gun_effect(pos)
	enable_raycast(pos)
	ammo_count -= 1
	shoot.emit()
	ammo_changed.emit(ammo_count)
	cooldown_timer = COOLDOWN_TIME


func set_light_on() -> void:
	show_light_timer = SHOW_LIGHT_TIME
	light.visible = true
	light.energy = 2.0
	if pony_sprite.flip_h:
		light.position = light_right_pos.position
	else:
		light.position = light_left_pos.position


func show_gun_effect(pos: Vector2) -> void:
	var effect = effect_right if pony_sprite.flip_h else effect_left
	effect.visible = true
	effect.look_at(pos)
	await get_tree().create_timer(0.1).timeout
	effect.visible = false


func enable_raycast(pos: Vector2) -> void: 
	raycast.position = effect_right.position if pony_sprite.flip_h else effect_left.position
	raycast.target_position = raycast.to_local(pos) * 50
	raycast.enabled = true
	raycast.force_raycast_update()
	var target = raycast.get_collider()
	handle_target(target, raycast.get_collision_point())
	raycast.enabled = false


func handle_target(target: Node, pos: Vector2) -> void:
	if target is CharacterBody2D:
		if target.has_node("die_controller"):
			var die = target.get_node("die_controller")
			die.die()
	else:
		if target.name == "dynamite":
			animate_explosion()
			return
		spawn_miss_sound(pos)


func spawn_miss_sound(pos: Vector2) -> void:
	miss_audi.global_position = pos
	miss_audi.stream = miss_sound
	miss_audi.play()


func animate_explosion() -> void:
	moving_controller.may_move = false
	spawn_explosion_sound()
	explosion_back.visible = true
	await get_tree().create_timer(0.5).timeout
	
	var lerp_index: float = 0
	
	while lerp_index < 0.1:
		explosion_back.color = explosion_back.color.lerp(Color.BLACK, lerp_index)
		lerp_index += 0.001
		await get_tree().process_frame
	
	Scenes.goto_scene("cave_dynamite_lost")


func spawn_explosion_sound() -> void:
	miss_audi.global_position = global_position
	miss_audi.stream = explosion_sounds[randi() % len(explosion_sounds)]
	miss_audi.play()
