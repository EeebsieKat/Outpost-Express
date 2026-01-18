extends AnimatedSprite2D

func _process(delta: float) -> void:
	z_index = -int(global_position.y)

func _on_turn_lights_on():
	print("turn on")
	play("TurnedOn")

func _on_turn_lights_off():
	print("turn off")
	play("TurnedOff")
