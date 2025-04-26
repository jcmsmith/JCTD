class_name BuildingManager
extends Node

@export var tile_map_layer : TileMapLayer = null

const BUILDABLE : String = "buildable"
const TOWER_GROUP : String = "TOWER_GROUP"

var used_tiles : Array[Vector2i] = []

func place_tower(cell_position : Vector2i, tower_packed_scene : PackedScene) -> void:
	if(!check_valid_tower_placement(cell_position)):
		return
	
	var new_tower : Node2D = tower_packed_scene.instantiate()
	add_child(new_tower)
	
	#I don't really get why we have to multiply this, it has to do with local_to_map in input handling
	new_tower.position = cell_position * 64
	new_tower.add_to_group(TOWER_GROUP)
	used_tiles.append(cell_position)
	
func check_valid_tower_placement(cell_position : Vector2i) -> bool:
	if used_tiles.has(cell_position):
		return false
		
	var is_buildable = tile_map_layer.get_cell_tile_data(cell_position).get_custom_data(BUILDABLE)
	return is_buildable
