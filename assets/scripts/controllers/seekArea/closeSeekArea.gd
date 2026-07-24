extends Area2D

class_name CloseSeekArea

@onready var ray: RayCast2D = get_node("ray")
@export var custom_victim_filter: Node

@export var state_machine: StateMachine
@export var ignore_states: Array[String] = ["attack"]
@export var check_only_player: bool = true
@export var see_enemy_state: String = "attack"

var all_victims: Array[CharacterBody2D]
var update_see_timer: bool = false
var see_timer: float


func _ready() -> void:
	update_see_timer = false


func _body_is_victim(body: Node2D) -> bool:
	if check_only_player:
		return body.has_node("input_controller")
	else:
		return body is CharacterBody2D


func _on_body_entered(body: Node2D) -> void:
	if body == get_parent(): return
	
	if _body_is_victim(body):
		all_victims.push_front(body)
		
		if !ignore_states.has(state_machine.current_state.name):
			see_timer = 0
			update_see_timer = true


func _on_body_exited(body: Node2D) -> void:
	if all_victims.has(body):
		all_victims.erase(body)
		
		if get_victim() == null && state_machine.current_state.name == see_enemy_state:
			see_timer = 0
			update_see_timer = false
			state_machine.enable_state("search" if see_enemy_state == "attack" else "idle")


func _process(delta: float) -> void:
	_update_see_timer(delta)
	_check_target_visible()


func get_victim() -> CharacterBody2D:
	if custom_victim_filter: return custom_victim_filter.filter(all_victims)
	if len(all_victims) > 0: return all_victims[0]
	return null


func _update_see_timer(delta: float) -> void:
	if !update_see_timer: return
	
	if see_enemy_state == "" || ignore_states.has(state_machine.current_state.name):
		update_see_timer = false
		return
	
	var victim = get_victim()
	if !victim: return
	
	ray.target_position = victim.global_position - ray.global_position
	ray.force_raycast_update()
	
	if ray.get_collider() == victim:
		if see_timer < 1:
			see_timer += _get_see_delta(delta)
			return
		state_machine.enable_state(see_enemy_state)
		update_see_timer = false


func _check_target_visible() -> void:
	var victim = get_victim()
	
	if victim && !victim.visible && state_machine.current_state.name == see_enemy_state:
		state_machine.enable_state("search" if see_enemy_state == "attack" else "idle")
		update_see_timer = true


func _get_see_delta(delta: float) -> float:
	var movement: MovementController = get_victim().get_node("movement_controller")
	var state = movement.current_state.name
	if state == "sit": return 2 * delta
	if state == "run": return 10 * delta
	return 5 * delta
