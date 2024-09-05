extends "res://Addings/Farts/chars/base_character.gd"


var tile_size: Vector2i
var target: Vector2i


func get_input(_delta) -> Vector2:
	var velocity_to: Vector2 = Vector2.ZERO
	## Get mouse click and vector
	velocity_to = get_target_direction(get_current_target())
	if (target - Vector2i(self.global_position)).length() > range:
		velocity_to *= shift / speed
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
	## Get target via get_current_star
	# Test with mouse click coords via _input(event)
	return target


func get_target_direction(target: Vector2) -> Vector2:
	target = target as Vector2
	var direction = self.global_position.direction_to(target)
	## Get local direction to target's position
	return direction
	
	
func _input(event) -> void:
	if event is InputEventMouseButton:
		target = event.position
