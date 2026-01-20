extends Node2D

# Note: we still need UI art for dialogues
# Note: you can use this as an prefab for dialogues.
# only thing to change is the path in line 13 and the if statement

var ballon_scene = preload("res://Dialogues/game_dialogue_ballon.tscn")

var package_scene = load("res://Scenes/Objects/Packages/package_1.tscn")

func interact_with_player():
	var ballon: BaseGameDialogueBalloon = ballon_scene.instantiate()
	get_tree().current_scene.add_child(ballon)
	ballon.start(load("res://Dialogues/Conversations/test_dialogue.dialogue"), "start")



func spawn_package():
	var package = package_scene.instantiate()
	get_tree().current_scene.add_child(package)
	package.position.y += 50
