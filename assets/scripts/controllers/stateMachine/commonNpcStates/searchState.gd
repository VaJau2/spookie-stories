extends StateBase

@export var seek_areas: Array[Area2D]
@export var anim_controller: AnimationController

const SEARCH_TIME: Array[float] = [2, 5]
var search_timer: float

const FLIP_TIME: Array[float] = [0.1, 1]
var flip_timer: float
var is_flip: bool


func enable() -> void:
	super.enable()
	var victim = _find_victim()
	if victim == null: 
		state_machine.enable_state("idle")
		return
	
	if movement_controller is NavigationMovementController:
		movement_controller.load_state("walk")
		movement_controller.set_target(victim.global_position)
	
	search_timer = randf_range(SEARCH_TIME[0], SEARCH_TIME[1])


func _process(delta: float) -> void:
	_update_flip(delta)
	
	if search_timer > 0:
		search_timer -= delta
	else:
		state_machine.enable_state("idle")


func _find_victim() -> CharacterBody2D:
	var victim = null
	
	for seek_area in seek_areas:
		var temp_victim = seek_area.get_victim()
		if temp_victim != null:
			victim = temp_victim
			break
	
	return victim

func _update_flip(delta: float) -> void:
	if flip_timer > 0:
		flip_timer -= delta
	else:
		anim_controller.set_flip(is_flip)
		is_flip = !is_flip
		flip_timer = randf_range(FLIP_TIME[0], FLIP_TIME[1])
