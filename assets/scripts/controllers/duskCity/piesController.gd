extends Node2D

class_name PiesController

const PIES_MAX_COUNT: int = 8

@export var pie_prefab: PackedScene

@export var autoaim_area: GamepadAutoAimArea
@export var moving_controller: MovementController
@export var shoot_sound: AudioStream

@onready var parent: CharacterBody2D = get_parent()
@onready var audi: AudioStreamPlayer2D = get_node("audi")

var pies_count : int = 0: set = set_pies_count
signal pies_changed(value: int)

var cooldown_timer: float
var COOLDOWN_TIME: float = 0.5


func set_pies_count(value: int) -> void:
	pies_count = value
	autoaim_area.is_active = pies_count > 0
	pies_changed.emit(value)


func _ready() -> void:
	var input_handler = get_node("/root/main/input")
	if !input_handler: return
	input_handler.shoot.connect(_on_shoot)


func _process(delta: float) -> void:
	if cooldown_timer > 0:
		cooldown_timer -= delta


func _on_shoot(pos: Vector2) -> void:
	if !moving_controller.may_move: return
	if pies_count <= 0: return
	if cooldown_timer > 0: return
	
	if autoaim_area.closest_enemy != null:
		pos = autoaim_area.closest_enemy.global_position
	
	audi.stream = shoot_sound
	audi.play()
	pies_count -= 1
	
	var pie: FlyingPie = pie_prefab.instantiate()
	pie.parent = parent
	get_node("../../").add_child(pie)
	call_deferred("_move_spawned_pie", pie, pos)


func _move_spawned_pie(pie: FlyingPie, dir_pos: Vector2) -> void:
	pie.global_position = global_position
	pie.fly_dir = (dir_pos - global_position).normalized() * 1000
