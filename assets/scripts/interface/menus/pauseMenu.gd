extends Control

class_name PauseMenu

@export var may_pause: bool = true


func _process(_delta: float) -> void:
	if !may_pause: return
	
	if Input.is_action_just_pressed("ui_cancel"):
		visible = !visible
		if visible:
			Engine.time_scale = 0
		else:
			Engine.time_scale = 1
