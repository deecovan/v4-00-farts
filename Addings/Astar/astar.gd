extends Node2D


# Astar grid
@onready var astar_grid = AStarGrid2D.new()
var static_tilemap_layer: TileMapLayer
var static_tile_size: Vector2
var global_center: Vector2


func set_astar() -> void:
	# Set up parameters, then update the grid.
	astar_grid.region = static_tilemap_layer.get_used_rect()
	astar_grid.cell_size = Vector2(static_tile_size)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ONLY_IF_NO_OBSTACLES
	astar_grid.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar_grid.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar_grid.update()
	for tile in get_used_static_cells():
		astar_grid.set_point_solid(tile,true)


func get_astar_path(from_position, to_position) -> Array:
	var from = static_tilemap_layer.local_to_map(from_position - global_center)
	var to = static_tilemap_layer.local_to_map(to_position - global_center)
	var arr_ids: Array = astar_grid.get_id_path(from, to)
	var arr_pos: Array[Vector2]
	for i in arr_ids:
		var pos := Vector2(
			global_center + 
			Vector2(i) * static_tile_size + 
			static_tile_size / 2
			)
		arr_pos.append(pos)
	#Test this sht
	#print(from, to)
	#print(arr_ids)
	return arr_pos


func get_used_static_cells() -> Array[Vector2]:
	var coords_array: Array[Vector2]
	var used_cells = static_tilemap_layer.get_used_cells()
	var ax := []
	var ay := []
	for ac in used_cells:
		ax.append(ac.x)
		ay.append(ac.y)
	for x in range(ax.min(), ax.max()):
		for y in range(ay.min(), ay.max()):
			var ctdata := static_tilemap_layer.get_cell_tile_data(Vector2(x, y))
			if ctdata.get_collision_polygons_count(0) > 0:
				coords_array.append((Vector2(x, y)))
	#Test this sht
	#print(coords_array)
	return coords_array
