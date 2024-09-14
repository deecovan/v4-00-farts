extends AudioStreamPlayer2D


func play_random() -> void:
	pitch_scale = randf_range(1.8, 2.4)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
