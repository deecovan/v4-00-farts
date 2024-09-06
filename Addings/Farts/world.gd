extends Node2D


@onready var base_npc: CharacterBody2D = $BaseNPC
@onready var statics: TileMapLayer = $Statics
@onready var camera: Camera2D = $Camera2D


func _ready() -> void:
	base_npc.tile_size = statics.tile_set.tile_size
	base_npc.camera = camera
	

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("alt_enter"):
		DisplayServer.window_set_mode(4 if (DisplayServer.window_get_mode()!=4) else 0)
