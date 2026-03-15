extends PointLight2D

var player: Node2D


func set_player(body: Node2D) -> void:
	player = body
	set_process(true)


func clear_player() -> void:
	set_process(false)


func _ready() -> void:
	clear_player()


func _process(_delta: float) -> void:
	global_position = player.global_position
