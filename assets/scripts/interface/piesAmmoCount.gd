extends Control

@export var player: CharacterBody2D
@export var usual_pie: Texture2D
@export var healing_pie: Texture2D


func _ready() -> void:
	var pies_controller: PiesController = player.get_node("pies_controller")
	_load_pies_count(pies_controller.pies_count, pies_controller.healing_pies_count)
	pies_controller.pies_changed.connect(_on_pies_count_changed)
	

func _on_pies_count_changed(value: int, healing_value: int) -> void:
	_load_pies_count(value, healing_value)


func _load_pies_count(value: int, healing_value: int) -> void:
	var index: int = 1
	for child in get_children():
		child.visible = index <= value
		child.texture = healing_pie if index <= healing_value else usual_pie
		index += 1
