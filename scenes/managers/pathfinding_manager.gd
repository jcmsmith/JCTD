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
	
	for y in tile_map_grid.get_used_rect().size.y:
		for x in tile_map_grid.get_used_rect().size.x:
			var enemy : EnemyEntity = testEnemy.instantiate()
			enemy.position = tile_map_grid.map_to_local(Vector2i(x,y))
			add_child(enemy)
