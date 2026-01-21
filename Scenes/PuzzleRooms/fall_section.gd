extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("Player Fell!")
		body.global_position = body.respawn_pos.global_position
		body.velocity = Vector2.ZERO
