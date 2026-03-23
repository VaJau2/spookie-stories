extends Area2D

@export var health_count: int = 50


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		var health_controller: HealthController = body.get_node("health_controller")
		if health_controller.health >= health_controller.max_health: 
			return
		
		health_controller.heal(health_count)
		queue_free()
