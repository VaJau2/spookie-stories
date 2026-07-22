extends Node

@export var player_node: Node2D
@export var dialogue_menu: DialogueMenu

var start_timer: float = 10


func _ready() -> void:
	set_process(false)


func start_count() -> void:
	set_process(true)


func _start_dialogue() -> void:
	var controller: MovementController = player_node.get_node("movement_controller")
	controller.set_may_move(false)
	dialogue_menu.start_dialogue("dusk_city", "lab_event")
	dialogue_menu.finished_dialogue.connect(_on_finished_dialogue)
	set_process(false)


func _on_finished_dialogue() -> void:
	var controller: MovementController = player_node.get_node("movement_controller")
	controller.set_may_move(true)
	queue_free()


func _process(delta: float) -> void:
	if !dialogue_menu.visible:
		if start_timer > 0:
			start_timer -= delta
		else:
			_start_dialogue()
