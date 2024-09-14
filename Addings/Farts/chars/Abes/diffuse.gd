extends Node2D


@export var square: Node2D
@export var from: CharacterBody2D
@export var to: CharacterBody2D
@export var timer: float = 0.0
@export var amount: int = 0:
	set(value):
		if value < 0:
			amount = 0
		else:
			amount = value


func _ready() -> void:
	amount = 10


func _process(delta: float) -> void:
	if(amount > 0):
		square.show()
		var coords: Vector2
		coords = lerp(
			from.global_position, to.global_position, timer * amount)
		print(coords)
		square.global_position = coords
		timer += delta
		amount -= 1
	else:
		square.hide()
		
