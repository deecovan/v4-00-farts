extends CharacterBody2D

@export var dexta := 5.0
@export var speed := 200.0
@export var shift := 400.0


var tile_size: Vector2
var camera: Camera2D
var func_get_astar_path: Callable
var func_get_free_static_cells: Callable
var global_center: Vector2


var target: Vector2
var astar_array: Array
var timer: float = 0.0

@onready var cross = $Cross

func _ready() -> void:
	print(name)
	## Set initial target from viewport center - World's Vector2(0,0)
	global_center = get_viewport().get_visible_rect().get_center()
	target = global_center


func _physics_process(delta: float) -> void:
	## Lerp physics
	velocity = lerp(velocity, get_input(delta) * speed, dexta * delta)
	move_and_slide()
	
		
func _input(event) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		## Set global target OR push it into targets_array
		set_current_target(
			event.global_position 
			#camera.global_position - global_center
			)


func get_random_position() -> Vector2:
	var free_cells: Array[Vector2] = func_get_free_static_cells.call()
	var rand_pos = free_cells.pick_random()
	return global_center + rand_pos * tile_size + tile_size / 2


func get_input(delta) -> Vector2:
	## Get mouse click and vector
	var velocity_to: Vector2 = global_position.direction_to(get_current_target())
	
	# Speed shift
	if astar_array.size() > 1:
		velocity_to *= shift / speed
	
	## If state == iddle
	timer += delta
	if velocity.length() < 10 and timer > 1:
		while not set_current_target(get_random_position()):
			print("Cant move to ", target)
		timer = 0.0
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
	
	
func set_current_target(targeted: Vector2) -> bool:
	target = targeted as Vector2
	astar_array = get_static_astar(target)
	return astar_array.size() > 0


func get_current_target():
	## Get target via get_current_star
	if astar_array.size() > 0:
		target = get_current_star()
	cross.global_position = target
	return target
