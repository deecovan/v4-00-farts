extends CharacterBody2D

@export var dexta := 5.0
@export var speed := 200.0 * 50 /Engine.physics_ticks_per_second
@export var shift := 400.0 * 50 /Engine.physics_ticks_per_second


var tile_size: Vector2
var camera: Camera2D
var func_get_astar_path: Callable
var func_get_free_static_cells: Callable
var astar_array: Array
var timer: float = 0.0
var global_center : Vector2
var target : Vector2
var target_obj: Node
var state_machine : FiniteStateMachine
var animations : AnimationPlayer
var particles : CPUParticles2D
var sounds : AudioStreamPlayer2D
var color : Color


func _init() -> void:
	print(name, " ready: ", set_color(pick_random_color()))


func set_color(mod_color: Color) -> Color:
	## Use one base color and add random Vector3 RGB
	var base_colors := [
		Color.CYAN, 
		Color.MAGENTA, 
		Color.YELLOW,
		#Color.RED, 
		#Color.GREEN, 
		#Color.BLUE
		]
	color = (mod_color + base_colors.pick_random())
	$Sprite2D.self_modulate = color
	$Cross.default_color = color * 0.6
	$Cross.hide()
	return color


func pick_random_color() -> Color:
	var rv = Vector3(randf(),randf(),randf()).normalized()
	return Color(rv.x, rv.y, rv.z)


func _physics_process(delta: float) -> void:
	## Move
	velocity = lerp(velocity, get_input(delta) * speed, delta * dexta)
	## Stop
	if velocity.length() < speed / dexta and astar_array.size() < 1:
		velocity = Vector2.ZERO
	move_and_slide()
	
	
func get_input(delta) -> Vector2:
	timer += delta
	## Get target and direction
	var velocity_to: Vector2 = global_position.direction_to(
		get_current_target()).normalized()
	
	# Speed shift
	if astar_array.size() > 1:
		velocity_to *= shift / speed
		
	# Collisions !!!HERE because FSM cant process slide_collisions
	if get_slide_collision_count() > 0:
		var normal = get_last_slide_collision().get_normal()
		position +=  normal * dexta + Vector2(
			randi_range(-8,8),randi_range(-8,8))
		velocity = Vector2.ZERO
		#print("Boom! ", name, " at ", position)
		reset_to_idle()

	if $Cross.default_color == Color.BLACK:
		print("Color IS BLACK!!! ", name)
		
	return velocity_to


func get_current_target():
	## Get target via get_current_star
	if astar_array.size() > 0:
		target = get_current_star()
		$Cross.global_position = target
	return target
	

func get_current_star() -> Vector2:
	## Get current star from Astar array
	var star: Vector2 = astar_array.front()
	if (star - self.global_position).length() < Vector2(tile_size / 2).length():
		astar_array.remove_at(0)
	return star


func set_current_target(new_target: Vector2) -> bool:
	target = new_target
	astar_array = get_static_astar(target)
	return astar_array.size() > 0
	

func update_current_target() -> bool:
	if target_obj is CharacterBody2D:
		target = target_obj.global_position
	else:
		return false
	astar_array = get_static_astar(target)
	if astar_array.size() <= 2:
		print(name, " Reached target: ", target_obj.name, " in time: ",
		"now" if int(timer) == 0 else "%s" % int(timer))
		target_obj = null
		reset_to("Success")
		return false
	else:
		print(name, " Updated target: ", target_obj.name, 
		" moves to: ", astar_array.size())
		return true
	
	
func get_random_position() -> Vector2:
	randomize()
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


func reset_to_idle(from_timer: float = 3.0) -> void:
	timer = from_timer
	target = global_position
	astar_array = []
	reset_to("Initial")
	
	
func reset_to_target(target_body: CharacterBody2D) -> void:
	target = target_body.global_position
	target_obj = target_body
	reset_to("Target")
	
	
func reset_to(fsm_state: StringName) -> void:
	state_machine.change_state(get_fsm_state(fsm_state))
	
	
func get_fsm_state(state_name: StringName) -> FSMState:
	for found_state in state_machine.states:
		if found_state.name == state_name:
			return(found_state)
	## if not found return initial as defined
	return state_machine.initial_state
