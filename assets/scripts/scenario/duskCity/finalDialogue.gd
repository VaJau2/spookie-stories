extends Node

@export var dialogue_menu: DialogueMenu

@export var healed_dialogue_code: String
@export var booped_dialogue_code: String

@onready var timer: Timer = get_node("timer")

var is_healed: bool


func play_final_dialogue(_is_healed: bool) -> void:
	is_healed = _is_healed
	timer.timeout.connect(_on_timeout)
	timer.start()


func _on_timeout() -> void:
	dialogue_menu.start_dialogue("dusk_city", healed_dialogue_code if is_healed else booped_dialogue_code)
