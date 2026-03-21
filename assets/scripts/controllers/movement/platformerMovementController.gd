extends MovementController

class_name PlatformerMovementController

@export var gravity = 10
@export var jump_force: float = 3
@export var on_floor: bool = true

var is_jumping: bool
var is_running: bool
var on_floor_cooldown: float

signal jumping
signal finish_jumping
signal stop_falling


func set_is_running(value: bool) -> void:
	is_running = value


func emit_move_signals() -> void:
	if dir.y != 0: return
	super()


func jump() -> void:
	if !on_floor && on_floor_cooldown <= 0: return
	on_floor_cooldown = 0
	jumping.emit()
	is_jumping = true
	dir.y = -jump_force + 0.6 if is_running else -jump_force


func _on_floor_changed() -> void:
	if on_floor:
		if is_jumping: finish_jumping.emit()
		is_jumping = false
		dir.y = 0
		load_state('run' if is_running else 'walk')
		if parent.velocity.length() > 0:
			move.emit()
		else:
			stop_falling.emit()
	else:
		if is_jumping: return
		on_floor_cooldown = 0.25
		#load_state("fall")


func _ready() -> void:
	load_state('default')


func _process(delta: float) -> void:
	if on_floor_cooldown > 0:
		on_floor_cooldown -= delta


func _physics_process(delta: float):
	var new_on_floor = parent.is_on_floor()
	if on_floor != new_on_floor:
		on_floor = new_on_floor
		_on_floor_changed()
	
	if !on_floor:
		dir.y += gravity * delta
	
	super(delta)
