class_name HighlightTile
extends Node2D

var grid_cell_size = 64

func _process(delta: float) -> void:
	follow_mouse_position()

func follow_mouse_position() -> void:
	var mouse_pos : Vector2i = get_global_mouse_position() / grid_cell_size
	
	position = mouse_pos * grid_cell_size
