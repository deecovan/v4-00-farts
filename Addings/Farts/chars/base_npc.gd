extends "res://Addings/Farts/chars/base_character.gd"


var tile_size: Vector2
var target: Vector2
var camera: Camera2D
var astar_array: Array
var func_get_astar_path: Callable
var global_center: Vector2


func _ready() -> void:
	## Set initial target from viewport center - World's Vector2(0,0)
	global_center = get_viewport().get_visible_rect().get_center()
	target = global_center
	
		
func _input(event) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		## Set global target OR push it into targets_array
		set_current_target(
			event.global_position + 
			camera.global_position - global_center
			)
		astar_array = get_static_astar(target)


func get_input(_delta) -> Vector2:
	var velocity_to: Vector2 = Vector2.ZERO
	## Get mouse click and vector
	velocity_to = global_position.direction_to(get_current_target())
	# Speed shift
	if astar_array.size() > 1:
		velocity_to *= shift / speed
	return velocity_to


func get_static_astar(targeted: Vector2) -> Array:
	## Get Astar Statics navigation array from Current position to Target position
	var targeted_astar_array = func_get_astar_path.call(self.global_position, targeted)
	return targeted_astar_array


func get_current_star() -> Vector2:
	## Get current star from Astar array
	var star: Vector2 = astar_array.front()
	if (star - self.global_position).length() < Vector2(tile_size / 2).length():
		astar_array.remove_at(0)
	return star
	
	
func set_current_target(targeted: Vector2) -> void:
	target = targeted as Vector2


func get_current_target():
	## Get target via get_current_star
	if astar_array.size() > 0:
		target = get_current_star()
	$Cross.global_position = target
	return target
