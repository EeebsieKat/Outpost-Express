extends Sprite2D

var target_position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func transition(current_position):
	target_position = current_position + Vector2(100, 100)
