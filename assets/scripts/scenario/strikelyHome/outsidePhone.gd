extends Node

@export var phone_audi: AudioStreamPlayer2D


func ring() -> void:
	phone_audi.play()
