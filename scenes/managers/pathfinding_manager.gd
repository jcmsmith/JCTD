class_name PathfindingManager
extends Node

@export var tile_map_grid : TileMapLayer = null
@export var testEnemy : PackedScene = null

var astar_grid : AStarGrid2D = AStarGrid2D.new()
var path_array : Array[Vector2i] = []


func _ready() -> void:
	setup_astar_grid()


func setup_astar_grid() -> void:
	astar_grid.region = tile_map_grid.get_used_rect()
	astar_grid.cell_size = tile_map_grid.tile_set.tile_size
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ONLY_IF_NO_OBSTACLES
	
	astar_grid.update()


func update_terrain_movement_values() -> void:
	#done in get_valid_path, but also here just in case
	path_array.clear()
	
	for i in tile_map_grid.get_used_cells():
		var tile_movement_cost = get_cell_movement_cost(i)
		
		if tile_movement_cost < 10:
			#Set grid point weight to equal movement cost set in TileSet
			astar_grid.set_point_weight_scale(i, tile_movement_cost)
		else:
			#Set grid point to be unwalkable
			astar_grid.set_point_solid(i, true)


func get_valid_path(start_pos : Vector2i, end_pos : Vector2i) -> Array[Vector2i]:
	path_array.clear()
	
	for point in astar_grid.get_point_path(start_pos, end_pos):
		var current_point : Vector2i = point
		
		#Ensure point is in center of cell
		current_point += astar_grid.cell_size / 2 as Vector2i
		
		path_array.append(current_point)
	
	return path_array


func get_cell_movement_cost(cell_position : Vector2i) -> int:
	return tile_map_grid.get_cell_tile_data(cell_position).get_custom_data_by_layer_id(1)
