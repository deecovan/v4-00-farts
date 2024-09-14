extends Node2D


func _draw() -> void:

	var from_pos = randi_range(-200,200)
	var to_pos = randi_range(-200,200)
	var amount = 1
	
	for i in amount:
		var sqarray := Array([[0,0],[0,64],[64,64],[64,0]])
		var square = PackedVector2Array(sqarray)
		var polygon: Polygon2D = Polygon2D.new()
		var color = Color.CORAL
		polygon.draw_colored_polygon(sqarray, color)
		add_child(polygon)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
