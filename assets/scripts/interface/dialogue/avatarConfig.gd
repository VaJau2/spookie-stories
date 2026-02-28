class_name AvatarConfig

var temp_code: String = ""

var eyes_open: int = 0
var eyes_closed: int = 1
var mouth_open: int = 2


func load_from_file(npc_name: String, state: String) -> void:
	var new_code = npc_name + state
	if temp_code == new_code: return
	
	var json_path = "res://assets/json/data/avatar_configs.json"
	var configs_data: Dictionary = JsonParse.read(json_path)
	
	var config = configs_data[npc_name][state]
	eyes_closed = config.eyes_closed
	eyes_open = config.eyes_open
	mouth_open = config.mouth_open
