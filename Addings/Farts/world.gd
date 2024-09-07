extends Node2D

@export var base_npc_tscn: PackedScene
@export var base_npc_gd: Script

@onready var astar: Node = $Astar
@onready var statics: TileMapLayer = $Statics
@onready var camera: Camera2D = $Camera2D

func _ready() -> void:
	## Instantiate NPC's
	inst_npcs()
	
	astar.global_center = get_viewport().get_visible_rect().get_center()
	astar.static_tilemap_layer = statics
	astar.static_tile_size = statics.tile_set.tile_size
	astar.set_astar()

	## Init all in group NPC's
	init_npcs()

func inst_npcs() -> void:
	var new_npc = base_npc_tscn.instantiate()
	new_npc.position = Vector2(
		-1000 - randi_range(100,1000), 
		-1000 - randi_range(100,1000))
	add_child(new_npc, true)
	new_npc.add_to_group("NPC")
	new_npc.set_script(base_npc_gd)


func init_npcs() -> void:
	for child in get_children():
		if child.is_in_group("NPC"):
			child.tile_size = statics.tile_set.tile_size
			child.camera = camera
			child.func_get_astar_path = astar.get_astar_path
			child.func_get_free_static_cells = astar.get_free_static_cells
			child.global_center = get_viewport().get_visible_rect().get_center()
			
			child.set_random_position()
			child.set_current_target(child.get_random_position())
			print(child.get_instance_id(), child.global_position, child.target)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("alt_enter"):
		DisplayServer.window_set_mode(4 if (DisplayServer.window_get_mode()!=4) else 0)
