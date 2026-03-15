extends Area2D

class_name DialogueArea

@export var is_active: bool = true
@export var player_node: Node2D
@export var player_name: String
@export var stop_player: bool = true
@export var move_player_after: bool = true
@export var dialogue_file: String
@export var dialogue_code: String
@export var dialogue_menu: DialogueMenu


func set_active() -> void:
	is_active = true


func _on_body_entered(body: Node2D) -> void:
	if !is_active: return
	
	if player_name != "" and player_node == null:
		if body.name == player_name:
			player_node = body
		else:
			return
	
	if player_node != null and body != player_node: return
	
	is_active = false
	dialogue_menu.start_dialogue(dialogue_file, dialogue_code)
	if stop_player and player_node != null:
		var controller: MovementController = player_node.get_node("movement_controller")
		controller.may_move = false
		if move_player_after:
			dialogue_menu.finished_dialogue.connect(_on_finished_dialogue)


func _on_finished_dialogue() -> void:
	var controller: MovementController = player_node.get_node("movement_controller")
	controller.may_move = true
	queue_free()
