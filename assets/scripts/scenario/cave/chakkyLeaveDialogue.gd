extends Node

@export var player: CharacterBody2D
@export var chakky: CharacterBody2D
@export var rats_manager: RatSpawnersManager
@export var dialogue_menu: DialogueMenu
@export var player_node: Node2D
@export var dialogue_file: String
@export var dialogue_code: String
@export var dialogue_code_short: String

@export var dir_light: DirectionalLight2D
@export var creepy_audi: AudioStreamPlayer 


func chakky_leave() -> void:
	chakky.queue_free()
	creepy_audi.set_on()
	dir_light.set_process(true)


func _on_timeout() -> void:
	if dialogue_menu.visible: return
	
	while !_may_start_dialogue(): 
		await get_tree().process_frame
	
	var code = dialogue_code_short if G.scene_vars.has("cave_leave_dialogue") else dialogue_code
	dialogue_menu.start_dialogue(dialogue_file, code)
	dialogue_menu.finished_dialogue.connect(_on_finished_dialogue)
	
	var controller: MovementController = player_node.get_node("movement_controller")
	controller.set_may_move(false)
	
	G.scene_vars.set("cave_leave_dialogue", 1)


func _on_finished_dialogue() -> void:
	var controller: MovementController = player_node.get_node("movement_controller")
	controller.set_may_move(true)
	queue_free()


func _may_start_dialogue() -> bool:
	if !player.is_on_floor(): return false
	if !chakky.is_on_floor(): return false
	for rat in rats_manager.rats:
		var distance = player.global_position.distance_to(rat.global_position)
		if distance < 500:
			return false
	return true
