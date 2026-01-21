extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("Player Fell!")
		body.global_position = Vector2(333, 225)
		body.velocity = Vector2.ZERO
