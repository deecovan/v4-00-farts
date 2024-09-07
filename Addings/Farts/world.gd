extends Node2D


@onready var astar: Node = $Astar
@onready var statics: TileMapLayer = $Statics
@onready var camera: Camera2D = $Camera2D

const base_npc_tscn := "res://Addings/Farts/chars/base_npc.tscn"

func _ready() -> void:
	## Instantiate NPC's
	ResourceLoader.load_threaded_request(base_npc_tscn)
	inst_npcs()
	## Than init all in group
	init_npcs()
	
	astar.global_center = get_viewport().get_visible_rect().get_center()
	astar.static_tilemap_layer = statics
	astar.static_tile_size = statics.tile_set.tile_size
	astar.set_astar()


func inst_npcs() -> void:
	var new_npc_res := ResourceLoader.load_threaded_get(base_npc_tscn)
	var new_npc = new_npc_res.instantiate()
	new_npc.position = Vector2(60,60)
	add_child(new_npc, true)


func init_npcs() -> void:
	for child in get_children():
		if child.is_in_group("NPC"):
			var base_npc: CharacterBody2D = $BaseNPC
			print(base_npc.get_instance_id())
			base_npc.tile_size = statics.tile_set.tile_size
			base_npc.camera = camera
			base_npc.func_get_astar_path = astar.get_astar_path
			base_npc.func_get_free_static_cells = astar.get_free_static_cells
			base_npc.global_center = get_viewport().get_visible_rect().get_center()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("alt_enter"):
		DisplayServer.window_set_mode(4 if (DisplayServer.window_get_mode()!=4) else 0)
