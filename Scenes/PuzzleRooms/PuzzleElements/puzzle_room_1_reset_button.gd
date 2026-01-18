extends Node2D

@onready var respawn_switches: Node = $"../Scripts/RespawnSwitches"
@onready var respwan_doors: Node = $"../Scripts/RespwanDoors"
@onready var lever_animation: AnimatedSprite2D = $"../AnimatedSprite2D"

func _ready() -> void:
	respawn_switches.respawn_switches()


# instatiates the light switches after interacting
func interact_with_player():
	lever_animation.play("Pulled")
	respawn_switches.respawn_switches()
