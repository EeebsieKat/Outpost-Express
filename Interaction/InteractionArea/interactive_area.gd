class_name InteractiveArea
extends Area2D

@onready var door: Sprite2D = $".."
@onready var door_collider: CollisionShape2D = $"../StaticBody2D/DoorCollider"
@onready var interactive_area: InteractiveArea = $"."
@onready var anim: AnimationPlayer = $"../AnimationPlayer"
@onready var close_door: AudioStreamPlayer2D = $"../CloseDoor"
@onready var open_door: AudioStreamPlayer2D = $"../OpenDoor"

signal interaction_available
signal interaction_unavailable
signal interacted

var is_open := false

@export var interact_input_action := "interact"


func _ready() -> void:
	interactive_area.interacted.connect(_on_interacted)
	set_process_unhandled_input(false)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(interact_input_action):
		interacted.emit()
		
func _on_interacted():
	is_open = !is_open

	if is_open:
		anim.play("open")
		open_door.play()
		door_collider.disabled = true
	else:
		anim.play("close")
		close_door.play()
		door_collider.disabled = false
	
func _on_area_entered(area: Area2D) -> void:
	set_process_unhandled_input(true)
	interaction_available.emit()

func _on_area_exited(area: Area2D) -> void:
	set_process_unhandled_input(false)
	interaction_unavailable.emit()
