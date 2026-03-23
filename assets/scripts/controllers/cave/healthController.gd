extends Node

class_name HealthController

@onready var audi: AudioStreamPlayer2D = get_node("audi")

const max_health: int = 100
var health: int = 100

signal healed
signal hitted
signal die


func hit(damage: int) -> void:
	health -= damage
	hitted.emit()
	
	if health <= 0:
		die.emit()


func heal(value: int) -> void:
	health += value
	health = clamp(health, 0, max_health)
	healed.emit()
	audi.play()
