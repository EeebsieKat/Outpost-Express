extends Node2D

@export var player: Player
@export var lightTiles: Node2D
@export var darkTiles: Node2D

func _ready() -> void:
	player.lantern_state_changed.connect(_on_lantern_toggled)
	_on_lantern_toggled(player.lantern_on)

func _on_lantern_toggled(is_on: bool) -> void:
	lightTiles.visible = is_on
	darkTiles.visible = not is_on
