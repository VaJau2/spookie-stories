extends Node

@export var dialogue_menu: DialogueMenu
@export var dialogue_file: String
@export var dialogue_code: String
@export var start_timer: float = 0


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_select"):
		start_timer = 0
	
	if start_timer > 0:
		start_timer -= delta
	else:
		dialogue_menu.start_dialogue(dialogue_file, dialogue_code)
		set_process(false)
