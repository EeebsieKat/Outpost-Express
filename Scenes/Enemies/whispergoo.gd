extends Node2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var detection_area: Area2D = $Area2D
@onready var detection_collision: CollisionShape2D = $Area2D/CollisionShape2D
@onready var whispergoo_ambient: AudioStreamPlayer2D = $WhispergooAmbient
@onready var blolb_hit: AudioStreamPlayer2D = $BlolbHit
@onready var hit_area: CollisionShape2D = $HitArea/CollisionShape2D

@export var target_offset_y := -16.0
@export var chase_speed := 100.0
@export var knockback_force := 200.0
@export var knockback_duration := 0.3
@export var attack_range := 24.0  # adjust as needed

var player: Player
var is_chasing := false
var lives := 3
var knockback_velocity := Vector2.ZERO
var knockback_timer := 0.0

func _ready() -> void:
	detection_area.body_entered.connect(_on_body_entered)
	detection_area.body_exited.connect(_on_body_exited)
	
	call_deferred("_find_player")

func _process(delta: float) -> void:
	hit_area.disabled = true
	if player == null:
		return

	if knockback_timer > 0:
		knockback_timer -= delta
		global_position += knockback_velocity * delta
		return
	
	should_chase()
	
	if is_chasing and not is_player_looking_at_me():
		move_toward_player()

func should_chase() -> void:
	is_chasing = detection_area.overlaps_body(player) and player.lantern_on

func move_toward_player() -> void:
	var target_pos := player.global_position + Vector2(0, target_offset_y)
	var direction := (target_pos - global_position).normalized()

	# Flip sprite
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true

	global_position += direction * chase_speed * get_process_delta_time()

func _find_player() -> void:
	var players = get_tree().get_nodes_in_group("Player")
	if players.size() > 0:
		player = players[0] as Player

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		should_chase()

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		should_chase()

func take_damage() -> void:
	print("Whispergoo Hit!")
	blolb_hit.play()
	lives -= 1
	
	if player != null:
		var knockback_direction := (global_position - player.global_position).normalized()
		knockback_velocity = knockback_direction * knockback_force
		knockback_timer = knockback_duration
	
	if lives <= 0:
		blolb_hit.play()
		queue_free()

func _on_whispergoo_ambient_finished() -> void:
	whispergoo_ambient.play()

func is_player_looking_at_me() -> bool:
	if player == null:
		return false

	var player_facing := player.get_facing_direction()
	var dir_to_me := (global_position - player.global_position).normalized()

	# Dot product: 1 = directly looking, 0 = perpendicular, -1 = opposite
	return player_facing.dot(dir_to_me) > 0.3

func attack_player():
	if player == null:
		return

	# Simple distance check
	if global_position.distance_to(player.global_position) <= attack_range:
		print("Whispergoo attacks!")
		hit_area.disabled = false
