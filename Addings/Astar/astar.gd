extends Node2D


# Astar grid
@onready var astar_grid = AStarGrid2D.new()
var static_tilemap_layer: TileMapLayer
var static_tile_size: Vector2i


func get_astar(from_position: Vector2, to_position: Vector2) -> Array:
	var tp := astar_grid.get_point_path(
		pos_to_point(from_position), pos_to_point(to_position)
		)
	var half_tile := Vector2(static_tile_size / 2)
	var fix_tp_arr: Array[Vector2]
	for fix_tp in tp:
		fix_tp_arr.append(fix_tp - half_tile)
	return fix_tp_arr


func set_astar() -> void:
	# Set up parameters, then update the grid.
	astar_grid.region = static_tilemap_layer.get_used_rect()
	astar_grid.cell_size = Vector2(static_tile_size)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ONLY_IF_NO_OBSTACLES
	astar_grid.update()
	# NOT All used cells are obstacles
	for tile in get_used_static_cells():
		astar_grid.set_point_solid(tile,true)


func get_used_static_cells() -> Array[Vector2i]:
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
	return astar_grid.get_point_path(from, to)


func pos_to_point(pos: Vector2) -> Vector2i:
	var point: Vector2i
	pos -= self.global_position
	point.x = int(pos.x / static_tile_size.x) 
	point.y = int(pos.y / static_tile_size.y)
	print("pos_to_point: ", pos, point)
	return point

## Not used ???
#func point_to_pos(point: Vector2) -> Vector2i:
	#var pos: Vector2i
	#var half_tile := static_tile_size / 2
	#pos.x = int(point.x) * static_tile_size.x + half_tile.x
	#pos.y = int(point.y) * static_tile_size.y + half_tile.y
	#print("point_to_pos: ", pos, point)
	#return pos
