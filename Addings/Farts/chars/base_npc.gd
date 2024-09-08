extends CharacterBody2D


@export var dexta := 5.0
@export var speed := 200.0
@export var shift := 400.0


var tile_size: Vector2
var camera: Camera2D
var func_get_astar_path: Callable
var func_get_free_static_cells: Callable
var astar_array: Array
var timer: float = 0.0
var global_center : Vector2
var target : Vector2


func _init() -> void:
	$Cross.default_color = Color(
		randf_range(0.75,1),
		randf_range(0.25,0.75),
		randf_range(0.25,0.75),)
	print(name, " ready")


func _physics_process(delta: float) -> void:
	## Lerp physics
	velocity = lerp(velocity, get_input(delta) * speed, delta * dexta)
	move_and_slide()
	
	
func get_input(delta) -> Vector2:
	timer += delta
	## Get mouse click and vector
	var velocity_to: Vector2 = global_position.direction_to(
		get_current_target())
	
	# Speed shift
	if astar_array.size() > 1:
		velocity_to *= shift / speed
	
	# Collisions
	if get_slide_collision_count() > 0:
		var normal = get_last_slide_collision().get_normal()
		position +=  normal * dexta + Vector2(
			randi_range(-8,8),randi_range(-8,8))
		#velocity *= -normal * Vector2(
			#randf_range(-1,1), randf_range(-1,1))
		velocity = Vector2.ZERO


	## If State == * and near is another Speaking
	## --> State Ignore -> State Moving
	## --> State Stop -> State Hearing -> State Decide
	
	## If State == Decide 
	## --> Speaking
	## --> Confirm
	## --> Deny	
	
	## If State == Folowing and target NPC is near
	## -> State Speaking
	
	## If State == Moving and near is target Position
	## -> State Idle
	
	## If State == Moving and Target Position not changing
	## -> State Stuck
	
	## If State == Stuck
	## If State == Iddle
	## -> State Looking 
	## --> State Pick new target (NPC or position) 
	## ---> State Moving to target
	
	## Stuck/Idle -> Moving
	if velocity.length() < 100 and timer > 3:
		timer = 0.0
		while not set_current_target(get_random_position()):
			print("%s can't move to %s, re-target" % [name, target])
		
		print(name, " Moving to ", target)
		
	return velocity_to


func get_random_position() -> Vector2:
	var free_cells: Array[Vector2] = func_get_free_static_cells.call()
	var rand_pos = free_cells.pick_random()
	return global_center + rand_pos * tile_size + tile_size / 2


func set_random_position() -> void:
	self.global_position = self.get_random_position()


func get_static_astar(targeted: Vector2) -> Array:
	## Get Astar Statics navigation array from Current position to Target position
	var targeted_astar_array = func_get_astar_path.call(
		self.global_position, targeted)
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
	$Cross.global_position = target
	return target
