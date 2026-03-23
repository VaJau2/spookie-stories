extends Node2D

class_name RatSpawnersManager

var rats: Array[CharacterBody2D]

@export var dialogue_menu: DialogueMenu

@export var rats_max_count: int = 10
@export var spawn_distance: float = 200
@export var max_spawn_distance: float = 800
@export var rat_prefabs: Array[PackedScene]
