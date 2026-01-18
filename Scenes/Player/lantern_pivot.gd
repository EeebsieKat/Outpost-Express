extends Node2D

@export var follow_speed := 8.0
@export var max_distance := 40.0

@export var bob_amount := 3.0
@export var bob_speed := 2.0

@export var target_path: NodePath

@onready var target: Node2D = get_node(target_path)

var velocity := Vector2.ZERO
var time := 0.0

func _ready():
	# IMPORTANT: start at the target
	global_position = target.global_position

func _physics_process(delta):
	time += delta

	var desired := target.global_position
	var offset := desired - global_position

	# --- critically damped spring ---
	velocity = velocity.lerp(offset * follow_speed, 0.15)
	global_position += velocity * delta

	# --- hard clamp ---
	if offset.length() > max_distance:
		global_position = desired - offset.normalized() * max_distance
		velocity = Vector2.ZERO

	# --- gentle bob ---
	global_position.y += sin(time * bob_speed) * bob_amount * delta
