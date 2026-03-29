extends Node

class_name SaveNode

var data = {
	"level_num": 0
}


func _ready() -> void:
	_load_data()


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		_save_data()


func _load_data() -> void:
	if FileAccess.file_exists("user://save.dat"):
		var file = FileAccess.open("user://save.dat", FileAccess.READ)
		var file_data = file.get_var()
		
		if file_data:
			if file_data.has("scene_vars"):
				G.scene_vars = file_data.get("scene_vars")
				file_data.erase("scene_vars")
			data = file_data
		
		file.close()


func _save_data() -> void:
	var file = FileAccess.open("user://save.dat", FileAccess.WRITE)
	if file:
		data["scene_vars"] = G.scene_vars
		file.store_var(data)
		data.erase("scene_vars")
		
		file.close()
