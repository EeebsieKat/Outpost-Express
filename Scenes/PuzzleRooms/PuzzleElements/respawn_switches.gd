extends Node

var switch_instances := []
const number_switches:= 3
var switch_position_y = 69.0
var light_switch_value := [true, false, false]

var light_switch = load("res://Scenes/PuzzleRooms/PuzzleElements/light_switch.tscn")


func respawn_switches():
	var switch_position_x = 59.0
	if switch_instances.size() != 0:
		# deletes old instances of the switches after resetting
		for number_instances in switch_instances.size():
			switch_instances[0].queue_free()
			switch_instances.remove_at(0)
			
	# instiates the light switches
	for i in number_switches:
		switch_instances.append(light_switch.instantiate())
		add_child(switch_instances[i])
		switch_instances[i].global_position.x = switch_position_x
		switch_instances[i].global_position.y = switch_position_y
		switch_position_x += 150
	
	light_switch_value = [true, false, false]
	
	for i in switch_instances.size():
		var random_int = randi_range(0, light_switch_value.size()-1)
		switch_instances[i].right_switch_value = light_switch_value[random_int]
		light_switch_value.remove_at(random_int)
	
	get_tree().call_group("LightSwitchReceiver", "reset_light")
	get_tree().call_group("PuzzleRoom1Door", "reset_door")
