extends Node

var switch_instances := []

const number_switches:= 3
var switch_position_y = 10.0

var light_switch_door = load("res://Scenes/PuzzleRooms/PuzzleElements/light_switch_door.tscn")


func respawn_doors(door_value_array: Array):
	print(door_value_array)
	var switch_position_x = 59.0
	if switch_instances.size() != 0:
		# deletes old instances of the switches after resetting
		for number_instances in switch_instances.size():
			switch_instances[0].queue_free()
			switch_instances.remove_at(0)
			
	# instiates the light switches
	for i in number_switches:
		switch_instances.append(light_switch_door.instantiate())
		add_child(switch_instances[i])
		switch_instances[i].right_door_value = door_value_array[i]
		switch_instances[i].global_position.x = switch_position_x
		switch_instances[i].global_position.y = switch_position_y
		switch_position_x += 150
	
