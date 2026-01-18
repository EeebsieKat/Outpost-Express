extends Area2D

var light_bulb_on := false
var warm = false

func interact_with_player():
	print(light_bulb_on)
	print(warm)

func _on_turn_switch_on():
	light_bulb_on = true
	warm = true

func _on_turn_switch_off():
	light_bulb_on = false

func reset_light():
	light_bulb_on = false
	warm = false
