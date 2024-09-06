extends "res://Addings/Farts/chars/base_character.gd"


var tile_size: Vector2
var target: Vector2
var camera: Camera2D
var astar_array: Array[Vector2]
var func_get_astar: Callable
var global_center: Vector2


func _ready() -> void:
	## Set initial target from viewport center - World's Vector2(0,0)
	target = global_center
	

func get_input(_delta) -> Vector2:
	var velocity_to: Vector2 = Vector2.ZERO
	## Get mouse click and vector
	velocity_to = get_target_direction(get_current_target())
	if (target - self.global_position).length() > 100:
		velocity_to *= shift / speed
	return velocity_to
	
	
func set_current_target(targeted: Vector2) -> void:
	target = targeted as Vector2


func get_current_target():
	## Get target via get_current_star
	if astar_array.size() > 0:
		target = get_current_star(astar_array)
	$Cross.global_position = target
	return target


func get_static_astar(targeted: Vector2) -> Array:
	## Get Astar Statics navigation array from Current position to Target position
	var targeted_astar_array = func_get_astar.call(self.global_position, targeted)
	return targeted_astar_array


func get_current_star(astar: Array[Vector2]) -> Vector2:
	## Get current star from Astar array
	var star: Vector2 = astar_array.front()
	if (star - self.global_position).length() < tile_size.length():
		astar_array.remove_at(0)
	return star


func get_target_direction(targeted: Vector2) -> Vector2:
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
		print(target, astar_array)
