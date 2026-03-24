extends AnimationController

class_name PlatformerAnimationController


func _ready() -> void:
	super()
	if movement_controller is PlatformerMovementController:
		movement_controller.stop_falling.connect(_on_stop_falling)
		movement_controller.jumping.connect(_on_jump)


func _on_stop_falling() -> void:
	anim.play("stop_falling")


func _on_jump() -> void:
	anim.play("jump")


func play_hit() -> void:
	anim.play("hit")
