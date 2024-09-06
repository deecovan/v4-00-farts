extends Node


# Astar grid
@onready var astar_grid = AStarGrid2D.new()
var static_tilemap_layer: TileMapLayer
var tilemap_path: Array
var static_tile_size: Vector2i


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func get_astar(from_position: Vector2, to_position: Vector2) -> Array:
	var astar_array: Array
	return astar_array
	
	
func set_astar() -> void:
	# Set up parameters, then update the grid.
	astar_grid.region = static_tilemap_layer.get_used_rect()
	astar_grid.cell_size = Vector2(static_tile_size)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ONLY_IF_NO_OBSTACLES
	astar_grid.update()
	# NOT All used cells are obstacles
	for tile in get_used_static_cells():
		astar_grid.set_point_solid(tile,true)
	# Test Astar
	tilemap_path = astar_grid.get_point_path(Vector2i(0,0), Vector2i(2, 0))
	print(tilemap_path)
	

func get_used_static_cells() -> Array[Vector2i]:
	var coords: Vector2i
	var coords_array: Array[Vector2i]
	var used_cells = static_tilemap_layer.get_used_cells()
	for x in range(used_cells.front().x, used_cells.back().x):
		for y in range(used_cells.front().y, used_cells.back().y):
			var ctdata := static_tilemap_layer.get_cell_tile_data(Vector2i(x, y))
			var pcount = ctdata.get_collision_polygons_count(0)
			if pcount > 0:
				coords_array.append(Vector2i(x, y))
	return coords_array

	
func get_apath(from_position, to_position) -> PackedVector2Array:
	var from = static_tilemap_layer.local_to_map(from_position)
	var to = static_tilemap_layer.local_to_map(to_position)
	tilemap_path = astar_grid.get_point_path(from, to)
	return tilemap_path

	
