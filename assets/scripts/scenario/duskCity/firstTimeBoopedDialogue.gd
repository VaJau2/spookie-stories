extends Node

@export var black_screen: ColorRect
@export var dialogue_menu: DialogueMenu
@export var ponies_counter: Node
@export var dialogues_to_disable: Array[DialogueArea]
@export var hint: HintLabel


func start_dialogue() -> void:
	for dialogue: DialogueArea in dialogues_to_disable:
		dialogue.is_active = false
	dialogue_menu.process_mode = Node.PROCESS_MODE_ALWAYS
	black_screen.color.a = 1
	get_tree().paused = true
	dialogue_menu.start_dialogue("dusk_city", "booped")
	dialogue_menu.finished_dialogue.connect(_on_finished)


func _on_finished() -> void:
	dialogue_menu.finished_dialogue.disconnect(_on_finished)
	dialogue_menu.process_mode = Node.PROCESS_MODE_INHERIT
	black_screen.set_process(true)
	get_tree().paused = false
	ponies_counter.set_booped()
	hint.hint_key = "boop"
	hint.show_hint()
