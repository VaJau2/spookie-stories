extends Area2D

@onready var shape_left: CollisionShape2D = get_node("shape_l")
@onready var shape_right: CollisionShape2D = get_node("shape_r")
@onready var ray: RayCast2D = get_node("ray")

@export var state_machine: StateMachine
@export var anim_controller: AnimationController

var player: CharacterBody2D
var see_timer: float


func _ready() -> void:
	set_process(false)
	anim_controller.flip_changed.connect(_on_flip_changed)


func _on_flip_changed(new_value: bool) -> void:
	shape_left.disabled = !new_value
	shape_right.disabled = new_value


func _on_body_entered(body: Node2D) -> void:
	if body.has_node("input_controller"):
		if state_machine.current_state.name != "attack":
			see_timer = 0
			player = body
			set_process(true)


func _on_body_exited(body: Node2D) -> void:
	if player == body:
		see_timer = 0
		player = null
		set_process(false)
		if state_machine.current_state.name == "attack":
			state_machine.enable_state("search")


func _process(delta: float) -> void:
	if state_machine.current_state.name == "attack":
		set_process(false)
		return
	
	ray.target_position = player.global_position - ray.global_position
	ray.force_raycast_update()
	
	if ray.get_collider() == player:
		if see_timer < 1:
			see_timer += _get_see_delta(delta)
			return
		state_machine.enable_state("attack")
		set_process(false)


func _get_see_delta(delta: float) -> float:
	var movement: MovementController = player.get_node("movement_controller")
	var state = movement.current_state.name
	if state == "sit": return 2 * delta
	if state == "run": return 10 * delta
	return 5 * delta
