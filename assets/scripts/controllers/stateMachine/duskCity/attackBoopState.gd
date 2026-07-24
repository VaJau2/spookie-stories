extends StateBase

const BOOP_COOLDOWN: Array[float] = [0.8, 1.5]

@export var seek_areas: Array[Area2D]
@export var animation_controller: AnimationController
@export var anim_player: AnimationPlayer
@export var boop_audi: AudioStreamPlayer2D

var victim: CharacterBody2D = null
var boop_cooldown: float


func enable() -> void:
	super.enable()
	_find_victim()
	if victim == null: 
		state_machine.enable_state("idle")
		return
	
	if movement_controller is MovementController:
		movement_controller.load_state(_get_move_state())
	
	if movement_controller is NavigationMovementController:
		movement_controller.came_to_point.connect(_on_came_to_point)
	
	anim_player.animation_finished.connect(_on_animation_finished)


func disable() -> void:
	super.disable()
	if anim_player.animation_finished.is_connected(_on_animation_finished):
		anim_player.animation_finished.disconnect(_on_animation_finished)
	if movement_controller is NavigationMovementController:
		if movement_controller.came_to_point.is_connected(_on_came_to_point):
			movement_controller.came_to_point.disconnect(_on_came_to_point)


func _process(_delta: float) -> void:
	_find_victim()
	var boop_point = _get_boop_point()
	var distance = parent.global_position.distance_to(boop_point.global_position)
	if distance > 10:
		boop_cooldown = 0
	
	if movement_controller is NavigationMovementController:
		movement_controller.set_target(boop_point.global_position)


func _on_came_to_point(delta: float) -> void:
	if boop_cooldown > 0:
		boop_cooldown -= delta
		return
	
	var sprite: Sprite2D = victim.get_node("sprite")
	animation_controller.set_flip(!sprite.flip_h)
	if movement_controller is MovementController:
		movement_controller.load_state("boop")
	
	boop_cooldown = randf_range(BOOP_COOLDOWN[0], BOOP_COOLDOWN[1])


func on_boop() -> void:
	var boop_point = _get_boop_point()
	var distance = parent.global_position.distance_to(boop_point.global_position)
	if distance > 10: return
	boop_audi.play_random()
	if victim.has_node("booped_state"):
		victim.get_node("booped_state").booped()
	if victim.has_node("state_machine"):
		victim.get_node("state_machine").enable_state("booped")


func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "boop":
		movement_controller.load_state(_get_move_state())


func _get_move_state() -> String:
	var booped = false
	
	if victim.has_node("booped_state"):
		booped = victim.get_node("booped_state").is_booped
	if victim.has_node("state_machine"):
		booped = victim.get_node("state_machine/booped").is_booped
	
	if booped:
		var distance = parent.global_position.distance_to(victim.global_position)
		return "run" if distance > 60 else "walk"
	else:
		return "run"

func _find_victim() -> void:
	for seek_area in seek_areas:
		var temp_victim = seek_area.get_victim()
		if temp_victim != null:
			victim = temp_victim
			break


func _get_boop_point() -> Node2D:
	var boop_points: Array = victim.get_node("boop_points").get_children()
	var sprite: Sprite2D = victim.get_node("sprite")
	if sprite.flip_h:
		return boop_points[0]
	else:
		return boop_points[1]
