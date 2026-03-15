extends Panel

class_name DialogueMenu

const DEFAULT_TIMER: float = 0.03

@export var ponies_parent: Node2D

@onready var movement_controller: MovementController = null
@onready var pause_menu: PauseMenu = get_tree().get_first_node_in_group("pause_menu")

@onready var text: RichTextLabel = get_node("text")
@onready var avatar: DialogueAvatar = get_node("avatar_point/avatar")
@onready var skip: Label = get_node("skip")
@onready var audi: DialogueAudi = get_node("audi")

var temp_anim: DialogueAnimController
var dialogue_data: Array
var speaker_name: String
var index: int = 0
var node_timer: float = DEFAULT_TIMER
var animation_timer: float = 0
var is_autoskip: bool = false

signal finished_dialogue


enum TypeEnum {
	phrase,
	new_state,
	script
}


func _process(delta: float) -> void:
	if !visible: return
	_animate_text(delta)
	
	if Input.is_action_just_pressed("ui_select"):
		if is_autoskip or text.visible_ratio >= 1:
			_next_node()
		else:
			text.visible_ratio = 1


func start_dialogue(file: String, code: String) -> void:	
	dialogue_data = _get_dialogue_data(file, code)
	if dialogue_data.is_empty(): return
	index = 0
	_show_node(dialogue_data[index])
	if pause_menu: pause_menu.may_pause = false
	if movement_controller: movement_controller.may_move = false
	visible = true


func finish_dialogue() -> void:
	avatar.close_connections()
	if pause_menu: pause_menu.may_pause = true
	if movement_controller: movement_controller.may_move = true
	visible = false
	finished_dialogue.emit()


func _show_node(node_data: Dictionary) -> void:
	is_autoskip = false
	var type = TypeEnum.get(node_data.type)
	match type:
		TypeEnum.phrase:
			if node_data.has("autoskip"): is_autoskip = true
			speaker_name = node_data.speaker
			_find_speaker_anim(speaker_name)
			audi.set_config(speaker_name)
			
			var state = node_data.state if node_data.has("state") else "idle"
			avatar.load_avatar(speaker_name, state, temp_anim)
			if temp_anim: temp_anim.set_state(state)
			text.text = node_data.text
			node_timer = node_data.timer if node_data.has("timer") else DEFAULT_TIMER
			animation_timer = 0
			text.visible_characters = 0
			skip.visible = false
		
		TypeEnum.new_state:
			var state = node_data.state if node_data.has("state") else "idle"
			speaker_name = node_data.speaker
			var anim = _find_speaker_anim(speaker_name)
			if anim is DialogueAnimController:
				anim.set_state(state)
			elif anim is MovementController:
				anim.load_state(state)
			_next_node()
		
		TypeEnum.script:
			var node = get_node(node_data.path)
			var method = node_data.method
			if node.has_method(method):
				node.call(method)
			_next_node()


func _next_node() -> void:
	index += 1
	if index < len(dialogue_data):
		_show_node(dialogue_data[index])
	else:
		finish_dialogue()


func _animate_text(delta: float) -> void:
	if text.visible_ratio >= 1:
		if is_autoskip:
			_next_node()
		else:
			skip.visible = true
			return
	
	if animation_timer > 0:
		animation_timer -= delta
		return
	
	text.visible_characters += 1
	var symbol = text.text[text.visible_characters - 1]
	if audi.may_play_dialogue_sound(text.visible_characters, symbol):
		audi.play_dialogue_sound(symbol)
		avatar.animate_mouth()
		if temp_anim: temp_anim.animate_mouth()
	
	animation_timer = _get_timer(node_timer, symbol)


func _get_timer(timer: float, new_symbol: String):
	match new_symbol:
		".", "!", "?": return timer + 0.4
		",": return timer + 0.1
		_: return timer


func _get_dialogue_data(file_name: String, dialogue_name: String) -> Array:
	var json_path = "res://assets/json/" \
		+ str(Enums.Lang.keys()[Loc.current_lang]) \
		+ "/dialogues/" + file_name + ".json"
	
	var json_data: Dictionary = JsonParse.read(json_path)
	if json_data.has(dialogue_name):
		return json_data[dialogue_name].nodes
	return []


func _find_speaker_anim(speaker_code: String):
	if ponies_parent == null: return
	var speaker = ponies_parent.get_node_or_null(speaker_code)
	if speaker == null: return
	if speaker.has_node("anim_controller"):
		temp_anim = speaker.get_node("anim_controller")
		return temp_anim
	if speaker.has_node("movement_controller"):
		return speaker.get_node("movement_controller")
	
