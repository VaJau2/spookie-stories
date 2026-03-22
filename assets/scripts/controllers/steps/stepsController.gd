extends AudioStreamPlayer2D

class_name StepsController

const WALK_COOLDOWN: float = 0.4
const RUN_COOLDOWN: float = 0.6

@export var movement_controller: MovementController
@export var steps_data: Array[StepData]
@export var default_material: Enums.Materials

var current_material: Enums.Materials
var curent_sound_array: Array[AudioStream]
var current_state: String = "walk"
var sound_index: int = 0
var timer: float = 0

var walk_cooldown: float = WALK_COOLDOWN
var run_cooldown: float = RUN_COOLDOWN


func _ready() -> void:
	current_material = default_material
	if movement_controller:
		movement_controller.move.connect(on_move)
		movement_controller.stop.connect(on_stop)
	on_stop()


func on_move() -> void:
	if !is_processing():
		timer = 0
		set_process(true)


func on_stop() -> void:
	if is_processing():
		set_process(false)


func on_change_material(new_material: Enums.Materials) -> void:
	current_material = new_material
	build_sound_array()


func _process(delta: float) -> void:
	if current_state != get_movement_state() or sound_index >= len(curent_sound_array):
		build_sound_array()
	
	if timer > 0:
		timer -= delta
	else:
		stream = curent_sound_array[sound_index]
		play()
		sound_index += 1
		timer = walk_cooldown if current_state == "walk" else run_cooldown


func build_sound_array() -> void:
	current_state = get_movement_state()
	var step_data = get_step_data()
	if !step_data: return
	curent_sound_array = step_data.run_sounds \
		if current_state == "run" \
		else step_data.walk_sounds
	curent_sound_array.shuffle()
	sound_index = 0
	walk_cooldown = step_data.walk_cooldown
	run_cooldown = step_data.run_cooldown


func get_step_data() -> StepData:
	for step_data in steps_data:
		if step_data.material_name == current_material:
			return step_data
	return null

func get_movement_state() -> String:
	if movement_controller: return movement_controller.current_state.name
	return current_state
