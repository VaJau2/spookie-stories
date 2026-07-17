extends Node

@export var body_sprite: Sprite2D
@export var eye_sprite: Sprite2D
@export var mane_sprite: Sprite2D
@export var mane_variants: Array[Texture2D]
@export var tail_sprite: Sprite2D
@export var tail_variants: Array[Texture2D]
@export var cloth_sprites: Array[Sprite2D]
@export var cloth_variants: Array[Texture2D]


func _ready() -> void:
	load_body_colors()
	load_hair()
	load_clothes()


func load_body_colors() -> void:
	body_sprite.modulate = Color(randf(), randf(), randf())
	eye_sprite.modulate = Color(randf(), randf(), randf())


func load_hair() -> void:
	var hair_color = Color(randf(), randf(), randf())
	mane_sprite.texture = mane_variants.pick_random()
	mane_sprite.modulate = hair_color
	tail_sprite.texture = tail_variants.pick_random()
	tail_sprite.modulate = hair_color


func load_clothes() -> void:
	for cloth in cloth_sprites:
		if len(cloth_variants) <= 0: return
		var cloth_visible = randf() < 0.25
		cloth.visible = cloth_visible
		if cloth_visible:
			cloth.modulate = Color(randf(), randf(), randf())
			var cloth_i = randi_range(0, len(cloth_variants) - 1)
			cloth.texture = cloth_variants.get(cloth_i)
			cloth_variants.remove_at(cloth_i)
