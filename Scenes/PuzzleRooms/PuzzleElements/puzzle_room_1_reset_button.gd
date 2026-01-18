extends Node2D

@onready var respawn_switches: Node = $"../Scripts/RespawnSwitches"
@onready var respwan_doors: Node = $"../Scripts/RespwanDoors"

func _ready() -> void:
	respawn_switches.respawn_switches()
#	respwan_doors.respawn_doors()

# instatiates the light switches after interacting
func interact_with_player():
	respawn_switches.respawn_switches()
#	respwan_doors.respawn_doors()
