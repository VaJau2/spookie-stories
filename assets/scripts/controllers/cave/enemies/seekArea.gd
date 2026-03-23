extends Area2D

class_name SeekArea

@onready var shape_l: CollisionShape2D = get_node("shape_l")
@onready var shape_r: CollisionShape2D = get_node("shape_r")

var cooldown_timer: float = 0

@export var state_machine: StateMachine

func _ready() -> void:
	state_machine.flip.connect(set_flip)


func _process(delta: float) -> void:
	if cooldown_timer > 0:
		cooldown_timer -= delta


func set_flip(value: bool) -> void:
	shape_l.disabled = !value
	shape_r.disabled = value


func _on_body_entered(body: Node2D) -> void:
	if cooldown_timer > 0: return
	if body.name == "player":
		state_machine.enable_state("attack")


func _on_body_exited(body: Node2D) -> void:
	if state_machine and body.name == "player":
		state_machine.enable_state("idle")
