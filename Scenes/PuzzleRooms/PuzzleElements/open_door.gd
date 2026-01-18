extends Area2D

var already_opened := false
@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"

func interact_with_player():
	if !already_opened:
		animated_sprite_2d.play("Pulled")
		already_opened = true
		get_tree().call_group("PuzzleRoom1Door", "_on_open_door")
	else:
		print("you already opened the door")

func reset_door():
	already_opened = false
