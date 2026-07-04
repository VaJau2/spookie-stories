extends Node

@export var player: Node2D
@export var start_dialogue: DialogueArea
@export var try_sleep_anim: Node
@export var scared_mother: Node
@export var dialogue_menu: DialogueMenu


func _ready() -> void:
	if G.scene_vars.has("strikely_home"):
		var saved_var = G.scene_vars.strikely_home
		if saved_var == 1:
			load_waked_up()


func load_waked_up() -> void:
	start_dialogue.is_active = false
	try_sleep_anim.change_to_night()
	scared_mother.get_up()
	var camera: Camera2D = player.get_node("camera")
	camera.reset_smoothing()
	var movement: MovementController = player.get_node("movement_controller")
	movement.may_move = false
	dialogue_menu.start_dialogue("strikely_home", "night3_repeat")
