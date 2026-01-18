extends Sprite2D

@onready var door: Sprite2D = $"."
@onready var door_collider: CollisionShape2D = $StaticBody2D/DoorCollider

func _ready():
	pass
	
func _on_interact():
	if !door_collider.disabled:
		door_collider.disabled = true
	elif door_collider.disabled:
		door_collider.disabled = false
