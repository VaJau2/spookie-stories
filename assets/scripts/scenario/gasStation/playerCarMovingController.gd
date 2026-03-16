extends Node

@export var input: InputHandler

@export var min_up_pos: float = -20
@export var max_up_pos: float = 150

@onready var car: Node2D = get_parent()


func _ready() -> void:
	set_process(false)


func _process(_delta: float) -> void:
	car.global_position.y += input.get_dir().y * 2.5
	car.global_position.y = clamp(car.global_position.y, min_up_pos, max_up_pos)
