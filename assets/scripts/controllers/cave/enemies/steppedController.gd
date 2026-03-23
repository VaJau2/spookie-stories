extends Node

@export var anim: AnimationPlayer
@onready var particles: GPUParticles2D = get_node("particles")

var manager: RatSpawnersManager


func die() -> void:
	particles.restart()
	var parent = get_parent()
	manager.rats.erase(parent)
	delete_children(parent)
	anim.play("stepped")
	await anim.animation_finished
	parent.queue_free()


func delete_children(parent: Node2D) -> void:
	for child in parent.get_children():
		if child == self: continue
		if child is Sprite2D: continue
		if child is AnimationPlayer: continue
		child.queue_free()
