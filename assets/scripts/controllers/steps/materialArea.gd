extends Area2D

@export var in_material: Enums.Materials
@export var out_material: Enums.Materials

var skip_change: bool = false


func _on_body_entered(body: Node2D) -> void:
	if body.has_node("audi_steps"):
		var steps: StepsController = body.get_node("audi_steps")
		steps.on_change_material(in_material)


func _on_body_exited(body: Node2D) -> void:
	if skip_change:
		skip_change = false
		return
	
	if body.has_node("audi_steps"):
		var steps: StepsController = body.get_node("audi_steps")
		steps.on_change_material(out_material)
