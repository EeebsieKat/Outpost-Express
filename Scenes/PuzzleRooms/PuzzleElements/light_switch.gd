extends Area2D

var turned_on = false
@onready var light_switch: Node2D = $".."
@onready var lever_animation: AnimatedSprite2D = $"../AnimatedSprite2D"

func interact_with_player():
	if !turned_on:
		lever_animation.play("LeverPulled")
		get_tree().call_group("PuzzleRoom1Door", "_on_close_door")
		print("Turned on")
		turned_on = true
		print("I am " + str(light_switch.right_switch_value))
		#lever_animation.play("LeverUnpulled")
		if light_switch.right_switch_value:
			get_tree().call_group("LightSwitchReceiver", "_on_turn_switch_on")
		else:
			get_tree().call_group("LightSwitchReceiver", "_on_turn_switch_off")
	else:
		print("Switcher already switched once")
