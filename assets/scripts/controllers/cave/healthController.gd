extends Node

class_name HealthController

var health: int = 100

signal hitted
signal die


func hit(damage: int) -> void:
	health -= damage
	hitted.emit()
	
	if health <= 0:
		die.emit()
