extends Area2D

@onready var parent: CharacterBody2D = get_parent()
@export var state_machine: StateMachine

var player: CharacterBody2D
var hear_timer: float


func _ready() -> void:
	set_process(false)


func _on_body_entered(body: Node2D) -> void:
	if body.has_node("input_controller"):
		hear_timer = 0
		player = body
		set_process(true)


func _on_body_exited(body: Node2D) -> void:
	if player == body:
		hear_timer = 0
		player = null
		set_process(false)


func _process(delta: float) -> void:
	if state_machine.current_state.name == "attack":
		return
	
	if hear_timer < 1:
		hear_timer += _get_see_delta(delta)
		return
	
	state_machine.enable_state("search")
	hear_timer = 0


func _get_see_delta(delta: float) -> float:
	if player.velocity.length() < 5: return 0
	var movement: MovementController = player.get_node("movement_controller")
	var state = movement.current_state.name
	var distance = player.global_position.distance_to(parent.global_position)
	
	if state == "sit": return 0
	if state == "run": return 200 * delta / distance
	return 100 * delta / distance
