extends "res://Addings/Farts/chars/base_character.gd"


var tile_size: Vector2i


func get_input(_delta) -> Vector2:
	var velocity_to: Vector2 = Vector2.ZERO
	## Get mouse click and vector
	velocity_to = get_target_direction(get_current_target()).normalized()
	return velocity_to
	
func get_static_astar(target: Vector2) -> Array[Vector2i]:
	target = target as Vector2
	var astar_array := [Vector2i.ZERO]
	## Get Astar Statics navigation array from Current position to Target position
	return astar_array

func get_current_star(astar: Array[Vector2i]) -> Vector2i:
	astar = astar as Array[Vector2i]
	var star := Vector2i.ZERO
	## Get current star from Astar array
	return star

func get_current_target():
	var target = self.position + Vector2(0, - tile_size.x)
	## Get target via get_current_star
	# Test with mouse click coords
	return target

func get_target_direction(target: Vector2) -> Vector2:
	target = target as Vector2
	var direction = Vector2.UP
	## Get local direction to target's position
	return direction