extends Node

@export var anim_controller: AnimationController

@export var lamp_l: Node2D
@export var lamp_r: Node2D


func _ready() -> void:
	anim_controller.flip_changed.connect(_on_flip_changed)


func _on_flip_changed(value: bool) -> void:
	lamp_l.visible = !value
	lamp_r.visible = value 
