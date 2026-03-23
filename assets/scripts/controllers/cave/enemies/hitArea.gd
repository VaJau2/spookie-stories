extends Area2D

@onready var shape_l: CollisionShape2D = get_node("shape_l")
@onready var shape_r: CollisionShape2D = get_node("shape_r")
@onready var audi: AudioStreamPlayer2D = get_node("audi")

@export var state_machine: StateMachine
@export var damage: int = 20


func _ready() -> void:
	state_machine.flip.connect(set_flip)


func set_flip(value: bool) -> void:
	shape_l.disabled = !value
	shape_r.disabled = value


func _on_body_entered(body: Node2D) -> void:
	if body.has_node("health_controller"):
		audi.play()
		var health: HealthController = body.get_node("health_controller")
		health.hit(damage)
