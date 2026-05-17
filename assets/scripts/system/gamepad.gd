extends Node

class_name GamepadChecker

var is_gamepad: bool = false

func _input(event: InputEvent) -> void:
	is_gamepad = event is InputEventJoypadButton or event is InputEventJoypadMotion
