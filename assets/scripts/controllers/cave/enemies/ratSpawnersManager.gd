extends Node2D

class_name RatSpawnersManager

var rats_count: int = 0

@export var rats_max_count: int = 10
@export var spawn_distance: float = 200
@export var max_spawn_distance: float = 800
@export var rat_prefabs: Array[PackedScene]
