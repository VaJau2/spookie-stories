extends Area2D

class_name FlyingPie

@onready var particles: GPUParticles2D = get_node("particles")

var live_delay: float = 8.0

var parent: CharacterBody2D
var fly_dir: Vector2


func _process(delta: float) -> void:
	_update_moving(delta)


func _update_moving(delta: float) -> void:
	if fly_dir.length() > 0:
		translate(fly_dir * delta)
		rotate(fly_dir.length() / 50 * delta)
		
		var deaccel_speed: float = 3
		fly_dir = lerp(fly_dir, Vector2.ZERO, deaccel_speed * delta)


func _on_screen_exit() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body == parent: return
	_handle_body(body)
	_enable_particles()
	queue_free()


func _handle_body(body: Node2D) -> void:
	if body.has_node("state_machine"):
		var state_machine: StateMachine = body.get_node("state_machine")
		state_machine.enable_state("pied")


func _enable_particles() -> void:
	particles.get_node("audi").play()
	
	var old_pos = particles.global_position
	particles.get_parent().remove_child(particles)
	get_parent().add_child(particles)
	particles.global_position = old_pos
	
	particles.emitting = true
