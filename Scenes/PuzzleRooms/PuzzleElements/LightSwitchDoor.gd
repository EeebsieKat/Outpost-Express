extends Area2D

@onready var light_switch_door: Node2D = $".."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"

func interact_with_player():
	animated_sprite_2d.play("Opened")
	print("open door")
	print(light_switch_door.right_door_value)
	if !light_switch_door.right_door_value:
		print("Wrong door.")
		get_tree().call_group("light_switch_door", "respawn_switches")
	else:
		print("Right door")
		get_tree().change_scene_to_file("res://Scenes/PuzzleRooms/riddle_1_final_room.tscn")
