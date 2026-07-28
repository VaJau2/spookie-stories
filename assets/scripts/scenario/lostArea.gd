extends Area2D

@export var state_machine: StateMachine
@export var player_name: String
@export var scene_name: String
@export var variable_name: String = "gas_station"
@export var variable_value: int = 1

@onready var black_screen: ColorRect = get_node("/root/main/menu/black_screen")
@onready var catch_audi: AudioStreamPlayer2D = get_node_or_null("audi")


func _on_body_entered(body: Node2D) -> void:
	if state_machine && state_machine.current_state.name == "idle":
		return
	
	if body.name == player_name:
		var box: PlayerBoxController = body.get_node_or_null("box_controller")
		if box && box.is_hiding: box.stop_hiding()
		var moving = body.get_node("movement_controller")
		moving.may_move = false
		set_process(true)
		if catch_audi: catch_audi.play()


func _ready() -> void:
	set_process(false)


func _process(delta: float) -> void:
	if black_screen.color.a < 1:
		black_screen.color.a += 3 * delta
	else:
		G.scene_vars.set(variable_name, variable_value)
		Scenes.goto_scene(scene_name)
