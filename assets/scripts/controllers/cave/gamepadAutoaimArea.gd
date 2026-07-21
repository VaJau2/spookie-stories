extends Area2D

class_name GamepadAutoAimArea

@onready var aim_point: Node2D = get_node("aim_point")
@export var target_point_y_pos: int = 18

var is_active: bool = true
var enemies: Array
var closest_enemy: CharacterBody2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("aim_target"):
		enemies.append(body)


func _on_body_exited(body: Node2D) -> void:
	if enemies.has(body):
		enemies.erase(body)


func _process(_delta: float) -> void:
	if !Gamepad.is_gamepad || !is_active:
		closest_enemy = null
		aim_point.visible = false
		return
	
	closest_enemy = _find_closest_enemy()
	aim_point.visible = closest_enemy != null
	if closest_enemy:
		var point_position = closest_enemy.global_position
		point_position.y -= target_point_y_pos
		aim_point.global_position = point_position


func _find_closest_enemy() -> CharacterBody2D:
	if len(enemies) == 0: return null
	
	var min_distance = global_position.distance_to(enemies[0].global_position)
	var temp_closest_enemy = enemies[0]
	
	for i in range(enemies.size()):
		if i == 0: continue
		var distance = global_position.distance_to(enemies[i].global_position)
		if distance < min_distance:
			temp_closest_enemy = enemies[i]
	
	return temp_closest_enemy
