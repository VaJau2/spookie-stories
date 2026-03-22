extends StateBase

@export var sprites: Array[Sprite2D]
@export var speed: float
@export var follow_distance: float
@export var seek_area: SeekArea

@onready var player: CharacterBody2D = get_node("/root/main/player")

var is_left: bool


func _process(_delta: float) -> void:
	var walk_left = parent.global_position.x > player.global_position.x
	
	var distance = abs(parent.global_position.x - player.global_position.x)
	
	if distance > follow_distance:
		parent.velocity.x = -speed if walk_left else speed
	else:
		parent.velocity.x = 0
	
	if is_left != walk_left:
		is_left = walk_left
		seek_area.set_flip(is_left)
		for sprite in sprites:
			sprite.flip_h = walk_left
