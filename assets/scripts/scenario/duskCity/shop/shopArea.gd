extends Area2D

@export var one_time: bool
@export var hint: Label
@export var player_body: CharacterBody2D
@export var shop_logic: Node
@export var shop_timer: Timer

@export_category("audi")
@export var shop_audi: AudioStreamPlayer2D
@export var door_sound: AudioStreamMP3
@export var buy_sound: AudioStreamMP3

var check_buy: bool


func _ready() -> void:
	set_process(false)
	shop_timer.timeout.connect(_on_shop_timer_timeout)


func _process(_delta: float) -> void:
	if player_body && Input.is_action_just_pressed("ui_up"):
		_enter_shop()


func _on_body_entered(body: Node2D) -> void:
	if body != player_body:
		return
	
	set_process(true)
	hint.visible = true
	hint.text = Loc.trans("interface.hints.shop_enter")


func _on_body_exited(body: Node2D) -> void:
	if body != player_body:
		return
	
	set_process(false)
	hint.visible = false


func _enter_shop() -> void:
	if one_time: monitoring = false
	change_player_visible(false)
	check_buy = true
	shop_timer.start()


func _on_shop_timer_timeout() -> void:
	if check_buy:
		shop_audi.stream = buy_sound
		shop_audi.play()
		shop_logic.proceed(player_body)
		check_buy = false
		shop_timer.start()
	else:
		_exit_shop()


func _exit_shop() -> void:
	change_player_visible(true)
	if shop_logic.has_method("proceed_exit"):
		shop_logic.proceed_exit()


func change_player_visible(value: bool) -> void:
	player_body.visible = value
	player_body.get_node("movement_controller").may_move = value
	shop_audi.stream = door_sound
	shop_audi.play()
