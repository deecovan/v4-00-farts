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
var square_array: Array


func _ready() -> void:
	amount = 10
	square = $Square
	from = $from
	to = $to
	for i in amount:
		var square_node = square.duplicate()
		square_array.append(square_node)
		self.add_child(square_node)
		square_node.add_to_group("diffuse")
		square_node.global_position += Vector2(randf_range(-20,20),randf_range(-20,20))
		square_node.show()

func _process(delta: float) -> void:
	timer += delta
	if(amount > 0 and from != null and to != null):
		var i := 0
		for child in get_children():
			i += 1
			if child.is_in_group("diffuse"):
				var coords: Vector2
				coords = lerp(
					from.global_position, to.global_position, 
					amount * i)
				square.global_position = coords
				timer += delta
			## Delete if more squares than amount
			if i > amount:
				child.queue_free()
		amount -= 1
		
