extends Node

@export var dialogues_to_disable: Array[DialogueArea]


func disable() -> void:
	for dialogue in dialogues_to_disable:
		dialogue.is_active = false
