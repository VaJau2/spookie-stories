extends Area2D

@export var spawn_wolfs_script: Node

var is_active: bool = false


func _on_body_entered(body: Node2D) -> void:
	if !is_active: return
	if body.name != "bowler_hat": return
	
	spawn_wolfs_script.delete_wolfs()
	is_active = false
