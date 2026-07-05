extends Label

@export var hint_key: String
@export var show_time: float = 2.0

var temp_trans_key: String = ""

func show_hint() -> void:
	_update_hint_text()
	visible = true
	modulate.a = 0
	while modulate.a < 1:
		modulate.a += 0.1
		await get_tree().process_frame
	set_process(true)


func _update_hint_text() -> void:
	var key = "interface.hints." + hint_key
	
	if Gamepad.is_gamepad:
		key += ".gamepad"
	else:
		key += ".keyboard"
	
	if temp_trans_key != key:
		temp_trans_key = key
		text = Loc.trans(key)


func _ready() -> void:
	set_process(false)


func _process(delta: float) -> void:
	if visible:
		_update_hint_text()
		
		if show_time > 0:
			show_time -= delta
		else:
			if modulate.a > 0:
				modulate.a -= delta * 3
			else:
				queue_free()
