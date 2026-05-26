extends Area2D

var player: CharacterBody2D
var trigger_timer: float = 0

signal corridor_trigger


func _ready() -> void:
	set_process(false)


func _process(delta: float) -> void:
	trigger_timer += _get_trigger_delta(delta)
	if trigger_timer >= 1:
		corridor_trigger.emit()
		set_process(false)


func _get_trigger_delta(delta: float) -> float:
	if player.velocity.length() < 5: return 0
	var movement: MovementController = player.get_node("movement_controller")
	var state = movement.current_state
	match state.name:
		"walk": return delta
		"run": return 5 * delta
		_: return 0


func _on_body_entered(body: Node2D) -> void:
	if body.has_node("input_controller") and trigger_timer < 1:
		player = body
		set_process(true)


func _on_body_exited(body: Node2D) -> void:
	if player == body:
		set_process(false)
