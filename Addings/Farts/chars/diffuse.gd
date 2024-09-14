extends Node2D


@export var from: CharacterBody2D
@export var to: CharacterBody2D
@export var amount: int = 0
@export var timer: float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var coords: Vector2
	for i in amount:
		coords = lerp(
			from.global_position, to.global_position, timer + i)
			## Test
		$Square.global_position = coords
		$Square.show()
		timer += delta
		
