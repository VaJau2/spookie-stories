extends Node

@export var dialogue_menu: DialogueMenu
@export var dialogue_file: String
@export var dialogue_code: String
@export var start_timer: float = 0


func _ready() -> void:
	if start_timer > 0:
		await get_tree().create_timer(start_timer).timeout
	dialogue_menu.start_dialogue(dialogue_file, dialogue_code)
