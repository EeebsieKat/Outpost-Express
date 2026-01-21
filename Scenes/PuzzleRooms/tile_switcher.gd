extends Node2D

@export var player: Player
@export var lightTiles: Node2D
@export var darkTiles: Node2D

func _ready() -> void:
	if player.lantern_on:
		lightTiles.visible = true
		darkTiles.visible = false
	else:
		lightTiles.visible = false
		darkTiles.visible = true
