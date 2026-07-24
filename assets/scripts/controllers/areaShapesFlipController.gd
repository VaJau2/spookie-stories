extends Node

@export var anim_controller: AnimationController
@export var shape_left: CollisionShape2D
@export var shape_right: CollisionShape2D


func _ready() -> void:
	anim_controller.flip_changed.connect(_on_flip_changed)


func _on_flip_changed(new_value: bool) -> void:
	shape_left.disabled = !new_value
	shape_right.disabled = new_value
