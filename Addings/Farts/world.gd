extends Node2D


@onready var base_npc: CharacterBody2D = $BaseNPC
@onready var statics: TileMapLayer = $Statics


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	base_npc.tile_size = statics.tile_set.tile_size
	# Print the size of the viewport.
	print("Viewport Resolution is: ", get_viewport().get_visible_rect().size)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
