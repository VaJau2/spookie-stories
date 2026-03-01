extends Node

@export var anim_to_skip: AnimationPlayer


func _process(_delta: float) -> void:
	if anim_to_skip.is_playing():
		if Input.is_action_just_pressed("ui_select"): 
			anim_to_skip.advance(anim_to_skip.current_animation_length - 1)
