extends Area2D

@export var crash_sounds: Array[AudioStream]

var is_active: bool = false


func _on_body_entered(body: Node2D) -> void:
	if !is_active: return
	
	if body.name == "car": 
		body.get_node("collide_with_obstacles").collide(self)
		return
	
	if body.name.begins_with("wolf_car"):
		body.collide()
		return
	
	var controller = body.get_node_or_null("movement_controller")
	if controller and controller is NavigationMovementController:
		controller.load_state("stun")
		is_active = false
		
		var audi = body.get_node_or_null("audi")
		if audi and len(crash_sounds) > 0:
			audi.stream = crash_sounds[randi() % len(crash_sounds)]
			audi.play()
