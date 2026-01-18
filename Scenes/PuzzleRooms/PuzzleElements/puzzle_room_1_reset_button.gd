extends Node2D

@onready var respawn_switches: Node = $"../Scripts/RespawnSwitches"

func _ready() -> void:
	respawn_switches.respawn_switches()

# instatiates the light switches after interacting
func interact_with_player():
	respawn_switches.respawn_switches()
