extends AudioStreamPlayer2D

@export var boops: Array[AudioStreamMP3]


func play_random() -> void:
	stream = boops.pick_random()
	play()
