extends Area2D

class_name SeekArea

@onready var shape_l: CollisionShape2D = get_node("shape_l")
@onready var shape_r: CollisionShape2D = get_node("shape_r")

@export var state_machine: StateMachine


func set_flip(value: bool) -> void:
	shape_l.disabled = !value
	shape_r.disabled = value


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		state_machine.enable_state("attack")


func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		state_machine.enable_state("idle")
