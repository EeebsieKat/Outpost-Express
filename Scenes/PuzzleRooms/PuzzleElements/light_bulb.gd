extends Area2D

var light_bulb_on := false
var warm = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func interact_with_player():
	print(light_bulb_on)
	print(warm)

func _on_turn_switch_on():
	light_bulb_on = true
	get_tree().call_group("AnimationLightBulb", "_on_turn_lights_on")
	warm = true

func _on_turn_switch_off():
	get_tree().call_group("AnimationLightBulb", "_on_turn_lights_off")
	light_bulb_on = false

func reset_light():
	get_tree().call_group("AnimationLightBulb", "_on_turn_lights_off")
	light_bulb_on = false
	warm = false
