extends Node2D

@export var texture : Texture2D:
	set(value):
		texture = value
		queue_redraw()
		
@export var polygon: Polygon2D:
	set(value):
		polygon = value
		queue_redraw()

var sqarray  :  Array[Vector2]
var square   :  PackedVector2Array
var color    :  Color


func _draw():
	## Test Draw Texture
	draw_texture(texture, Vector2())
	## Draw Square
	sqarray = [
		Vector2(0,0),
		Vector2(0,64),
		Vector2(64,64),
		Vector2(64,0),
		]
	square = PackedVector2Array(sqarray)
	color = Color.CORAL
	draw_colored_polygon(square, color)
