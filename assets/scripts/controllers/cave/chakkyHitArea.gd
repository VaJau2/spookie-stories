extends Area2D

@export var anim_controller: PlatformerAnimationController
@export var try_hit_audi: AudioStreamPlayer2D
@export var hit_audi: AudioStreamPlayer2D

@onready var shape_l: CollisionShape2D = get_node("shape_l")
@onready var shape_r: CollisionShape2D = get_node("shape_r")


func _ready() -> void:
	anim_controller.flip_changed.connect(_on_flip_changed)


func _on_flip_changed(value: bool) -> void:
	shape_l.disabled = !value
	shape_r.disabled = value


func _on_body_entered(body: Node2D) -> void:
	if body.has_node("die_controller"):
		try_hit_audi.play()
		anim_controller.play_hit()
		if randf() < 0.5:
			var controller = body.get_node("die_controller")
			controller.die()
			hit_audi.play()
	
