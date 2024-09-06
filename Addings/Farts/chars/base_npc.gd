extends "res://Addings/Farts/chars/base_character.gd"


var tile_size: Vector2
var target: Vector2
var camera: Camera2D
var astar_array: Array
var func_get_astar: Callable


func _ready() -> void:
	target = get_viewport().get_visible_rect().get_center()
	

func get_input(_delta) -> Vector2:
	var velocity_to: Vector2 = Vector2.ZERO
	## Get mouse click and vector
	velocity_to = get_target_direction(get_current_target())
	if (target - self.global_position).length() > rangf:
		velocity_to *= shift / speed
	return velocity_to
	
	
func set_current_target(targeted: Vector2) -> void:
	target = targeted as Vector2


func get_current_target():
	## Get target via get_current_star
	# Test with mouse click coords via _input(event)
	$Cross.global_position = target
	return target


func get_static_astar(targeted: Vector2) -> Array:
	targeted = targeted as Vector2
	## Get Astar Statics navigation array from Current position to Target position
	var targeted_astar_array = func_get_astar.call(self.global_position, targeted)
	return targeted_astar_array


func get_current_star(astar: Array) -> Vector2:
	astar = astar as Array
	var star := Vector2.ZERO
	## Get current star from Astar array
	return star


func get_target_direction(targeted: Vector2) -> Vector2:
	targeted = targeted as Vector2
	var direction = self.global_position.direction_to(target)
	## Get local direction to target's position
	return direction
	
	
func _input(event) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		## Set global target OR push it into targets_array
		set_current_target(
			event.global_position + 
			camera.global_position - get_viewport().get_visible_rect().get_center()
			)
		astar_array = get_static_astar(target)
		print(astar_array)
