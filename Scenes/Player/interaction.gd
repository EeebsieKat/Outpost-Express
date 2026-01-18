extends RayCast2D

# RayCast rotation does not work properly

@onready var interaction_ray_cast: RayCast2D = $"."

var last_direction : Vector2
@onready var red: Player = $".."

const raycast_length := 20

func _physics_process(delta: float) -> void:
	if red.character_direction != Vector2.ZERO:
		last_direction = red.character_direction.normalized()
		print(last_direction)
	
	interaction_ray_cast.target_position = last_direction * raycast_length
	
	# saves the colliding object
	interaction_ray_cast.force_raycast_update()
	var current = interaction_ray_cast.get_collider()
	if current != null:
		print(current.name)
	
	if current != null and Input.is_action_just_pressed("interact"):
		print("Is colliding")
		interact(current)

func interact(body):
	if body.has_method("interact_with_player"):
		print("Plays function")
		body.interact_with_player()
	print("Collided", body)
