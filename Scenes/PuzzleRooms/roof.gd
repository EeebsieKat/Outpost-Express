extends Sprite2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	visible = false


func _on_area_2d_body_exited(body: Node2D) -> void:
	visible = true
