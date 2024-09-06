extends Node2D


@onready var base_npc: CharacterBody2D = $BaseNPC
@onready var statics: TileMapLayer = $Statics


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	base_npc.tile_size = statics.tile_set.tile_size
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("alt_enter"):
		DisplayServer.window_set_mode(
			DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN 
			if (DisplayServer.window_get_mode()!=DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN) 
			else DisplayServer.WINDOW_MODE_WINDOWED
			)
