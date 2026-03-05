extends Area2D

@export var player_node: Node2D
@export var stop_player: bool = true
@export var dialogue_file: String
@export var dialogue_code: String
@export var dialogue_menu: DialogueMenu

var is_active: bool = true


func _on_body_entered(body: Node2D) -> void:
	if !is_active: return
	if player_node == null or body == player_node:
		is_active = false
		dialogue_menu.start_dialogue(dialogue_file, dialogue_code)
		if stop_player and player_node != null:
			var controller: MovementController = player_node.get_node("movement_controller")
			controller.may_move = false
			dialogue_menu.finished_dialogue.connect(_on_finished_dialogue)


func _on_finished_dialogue() -> void:
	var controller: MovementController = player_node.get_node("movement_controller")
	controller.may_move = true
