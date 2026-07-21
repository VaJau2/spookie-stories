extends Control

@export var player: CharacterBody2D


func _ready() -> void:
	var pies_controller: PiesController = player.get_node("pies_controller")
	_load_pies_count(pies_controller.pies_count)
	pies_controller.pies_changed.connect(_on_pies_count_changed)
	

func _on_pies_count_changed(value: int) -> void:
	_load_pies_count(value)


func _load_pies_count(value: int) -> void:
	var index: int = 1
	for child in get_children():
		child.visible = index <= value
		index += 1
