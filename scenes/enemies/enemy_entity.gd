class_name EnemyEntity
extends CharacterBody2D

@export var pathfinding_manager : PathfindingManager = null
@export var target_pos : Marker2D = null
@export var movement_speed : float = 200.0

var path_array : Array[Vector2i] = []

func _ready() -> void:
	path_array = pathfinding_manager.get_valid_path(global_position / 64, target_pos.position / 64)

func _process(_delta: float) -> void:
	get_path_to_position()
	move_and_slide()

func get_path_to_position() -> void:
	if len(path_array) > 0:
		#Vector2, NOT Vector2i
		var direction : Vector2 = global_position.direction_to(path_array[0])
		
		velocity = direction * movement_speed
		
		if global_position.distance_to(path_array[0]) <= 10:
			path_array.remove_at(0)
	else:
		velocity = Vector2.ZERO
