extends Node

class_name HealthController

signal hitted


func hit(_damage: int) -> void:
	hitted.emit()
