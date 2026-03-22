extends BoxContainer

class_name AmmoInterface

@export var ammo_icon_prefab: PackedScene
@export var player: Node2D


func _ready() -> void:
	var player_gun: RevolverController = player.get_node("revolver_controller")
	player_gun.ammo_changed.connect(_on_ammo_changed)
	load_ammo_icons(player_gun.ammo_count)


func _on_ammo_changed(count: int) -> void:
	load_ammo_icons(count)


func load_ammo_icons(count: int) -> void:
	for icon in get_children():
		icon.queue_free()
	
	for i in range(count):
		var ammo_icon = ammo_icon_prefab.instantiate()
		add_child(ammo_icon)
