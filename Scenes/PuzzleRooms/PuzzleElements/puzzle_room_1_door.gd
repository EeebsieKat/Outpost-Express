extends Node2D

var door_opened = false

var closed_positon := 165.0
var opened_position := 115.0

var direction := 1

var speed := 5

# moves door
func _process(delta: float) -> void:
	if door_opened:
		if position.y > opened_position:
			position.y += direction * -speed
	else:
		if position.y < closed_positon:
			position.y += direction * speed

func _on_open_door():
	door_opened = true

func _on_close_door():
	door_opened = false

func reset_door():
	door_opened = false
