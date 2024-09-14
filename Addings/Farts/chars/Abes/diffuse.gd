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
	square = $Square
	from = $from
	to = $to


func _process(delta: float) -> void:
	if(amount > 0 and from != null and to != null):
		print(from)
		square.show()
		var coords: Vector2
		coords = lerp(
			from.global_position, to.global_position, timer * amount)
		square.global_position = coords
		timer += delta
		amount -= 1
	else:
		square.hide()
		
