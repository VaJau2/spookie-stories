extends StateBase

const WALK_TIME: Array[float] = [1, 5]

@export var sprites: Array[Sprite2D]
@export var speed: float
@export var seek_area: SeekArea

var walk_timer: float
var walk_left: bool


func _update_walk() -> void:
	parent.velocity.x = -speed if walk_left else speed


func _process(delta: float) -> void:
	if walk_timer > 0:
		walk_timer -= delta
		_update_walk()
	else:
		walk_timer = randf_range(WALK_TIME[0], WALK_TIME[1])
		walk_left = !walk_left
		seek_area.set_flip(walk_left)
		for sprite in sprites:
			sprite.flip_h = walk_left
