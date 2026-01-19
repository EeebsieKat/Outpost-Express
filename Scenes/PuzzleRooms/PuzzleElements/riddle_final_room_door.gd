extends Area2D

func interact_with_player():
	# change the path to the scene we came from
	get_tree().change_scene_to_file("res://Scenes/Test/main_test_scene.tscn")
