class_name Player
extends CharacterBody2D

signal lantern_state_changed(state: bool)

@onready var staff_swing: AudioStreamPlayer2D = $StaffSwing


@onready var sprite: Sprite2D = $PlayerSprite
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var lantern_pivot: Node2D = $LanternSide/LanternPivot
@onready var staff_hitbox: Area2D = $StaffHitbox
var staff_hitbox_offset: int = 19

@onready var lantern_side: Node2D = $LanternSide
@export var lantern_side_offset: float = 16.0
@export var lantern_height := -20.0
@onready var lantern_target: Node2D = $LanternSide/LanternTarget

#Lights
@onready var lantern_light: PointLight2D = $Lantern/LanternSprite/LanternLight
@onready var lantern_light_2: PointLight2D = $Lantern/LanternSprite/LanternLight2
@onready var lantern_light_3: PointLight2D = $Lantern/LanternSprite/LanternLight3
@onready var lantern_light_4: PointLight2D = $Lantern/LanternSprite/LanternLight4

# Colliders
@onready var lantern_light_area_collider: CollisionShape2D = $LanternLightArea/LanternLightAreaCollider

@export var movement_speed : float = 200
var character_direction : Vector2

var is_attacking: bool = false
var remaining_fuel = GameManager.fuel_amount
var lantern_on := true

@onready var interaction_ray_cast: RayCast2D = $InteractionRayCast

func _process(_delta):
	if Input.is_action_just_pressed("toggle_light"):
		lantern_on = !lantern_on
		lantern_state_changed.emit(lantern_on)
		lantern_light.enabled = lantern_on
		lantern_light_2.enabled = lantern_on
		lantern_light_4.enabled = lantern_on

		lantern_light_area_collider.call_deferred(
			"set_disabled",
			!lantern_on
		)


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("attack") and not is_attacking:
		attack()
		
	if is_attacking:
		velocity = Vector2.ZERO
		return
	
	if Input.is_action_just_pressed("interact"):
		for item in get_tree().get_nodes_in_group("DeliveryItems"):
			if global_position.distance_to(item.global_position) < 16:
				if not item.picked_up:
					item.picked_up = true
					item.holder = self
				elif item.picked_up and item.holder == self:
					if global_position.distance_to(item.delivery_spot.global_position) < 16:
						item.queue_free()  # delivered
						
	character_direction.x = Input.get_axis("left", "right")
	character_direction.y = Input.get_axis("up", "down")
	character_direction = character_direction.normalized()
	
	# Sprite Flip
	if character_direction.x > 0:
		sprite.flip_h = false
		lantern_target.position.x = lantern_side_offset
		staff_hitbox.position.x = staff_hitbox_offset
	elif character_direction.x < 0:
		sprite.flip_h = true
		lantern_target.position.x = -lantern_side_offset
		staff_hitbox.position.x = -staff_hitbox_offset + 10

	lantern_target.position.y = lantern_height
	
	if character_direction:
		if is_attacking:
			return
		velocity = character_direction * movement_speed
		if !anim.is_playing() or anim.current_animation != "walk":
			anim.play("walk")
	else:
		if is_attacking:
			return
		velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
		if !anim.is_playing() or anim.current_animation != "idle":
			anim.play("idle")
			
	move_and_slide()

func attack() -> void:
	is_attacking = true
	staff_swing.play()
	anim.play("attack")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if is_attacking:
		is_attacking = false
